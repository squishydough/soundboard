; set to pinned or hidden, used for toggling window position
global gui_state = pinned
; category textfield user input
global user_category_text := ""
; individual sound textfield user input
global user_individual_text := ""
; tracks which command selected from the dropdown menu
global command_choice := ""
; tracks whether the user hit enter in the filter text field
global text_field_enter_pressed := false
; The pid of the vlc instance - used for stopping sounds
global vlc_pid := ""
; Tracks which sounds are unplaye for each category
; Helps ensure that the same sound doesn't play back to back
global unplayed_sounds := []
; List of all sounds
global sounds := []
; List of all categories
global categories := []
; Second keyboard values
global AHI := ""
global keyboard_id := ""

CapsLock & Space::
  gui_toggle()
  return

GuiEscape:
  stop_sound()
  gui_toggle()
  return

; Allow normal CapsLock functionality to be toggled by Alt+CapsLock:
!CapsLock::
  GetKeyState, capsstate, CapsLock, T ;(T indicates a Toggle. capsstate is an arbitrary varible name)
  if capsstate = U 
  {
    SetCapsLockState, AlwaysOn
  }
  else 
  {
    SetCapsLockState, AlwaysOff
  }
  return

;----------------------------------------------------
;;;   Creates new instance of soundboard GUI
;----------------------------------------------------
gui_create() {
  ; Initialize state
  AHI := new AutoHotInterception()
  gui_state = pinned
  ; Initialize data
  sounds := get_all_sounds()
  categories := get_all_categories()
  unplayed_sounds := []
  ; Tomorrow Night Color Definitions:
  cBackground := "c" . "1d1f21"
  cCurrentLine := "c" . "282a2e"
  cSelection := "c" . "373b41"
  cForeground := "c" . "c5c8c6"
  cComment := "c" . "969896"
  cRed := "c" . "cc6666"
  cOrange := "c" . "de935f"
  cYellow := "c" . "f0c674"
  cGreen := "c" . "b5bd68"
  cAqua := "c" . "8abeb7"
  cBlue := "c" . "81a2be"
  cPurple := "c" . "b294bb"
  ; -E0x200 removes border around Edit controls
  gui_control_options := "xm w520 " . cForeground . " -E0x500"

  if(intercept_keyboard == 0) 
  {
    intercept_keyboard_checked = Checked0
  }
  else 
  {
    intercept_keyboard_checked = Checked1
  }

  if(include_category_when_filtering_specific_sounds == 0)
  {
    include_categories_checked = Checked0
  }
  else
  {
    include_categories_checked = Checked1
  }

  Gui, Margin, 16, 16
  Gui, +AlwaysOnTop
  Gui, Color, 1d1f21, 282a2e
  Gui, Font, s11, Segoe UI
  Gui, Add, Text, %gui_control_options% x16 y8, Filter Sounds
  Gui, Add, Text, %gui_control_options% x16 y64, Random Sound From Category
  Gui, Add, Text, %gui_control_options% x16 y228, Specific Sound
  Gui, Add, Text, -E0x500 x16 y564 %cForeground%, Other Commands
  Gui, Font, s10, Segoe UI
  Gui, Add, Edit, %gui_control_options% x16 y32 vuser_category_text gfilter_sounds -WantReturn
  Gui, Add, CheckBox, vinclude_category_when_filtering_specific_sounds gfilter_sounds -E0x500 x224 y228 %cForeground% %include_categories_checked%, Include Category When Filtering Specific Sounds?
  Gui, Add, CheckBox, vintercept_keyboard gkeyboard_toggle -E0x500 x352 y8 %cForeground% %intercept_keyboard_checked%, Intercept second keyboard?
  Gui, Add, Button, w80 gstop_sound x452 y564, Stop Sound
  Gui, Add, Button, Default x-10 y-10 w1 h1 ghandle_textfield_submit
  Gui, Add, DropDownList, -E0x500 %cForeground% x148 y564 vcommand_choice ghandle_command_dropdown, ---||Clear Clipboard|Reload
  Gui, Font, s09, Segoe UI
  Gui, Add, ListView, %gui_control_options% x16 y92 AltSubmit ghandle_category_listview, Category
  Gui, Add, ListView, %gui_control_options% x16 y256 AltSubmit h300 ghandle_individual_listview, Name | Categories | File Name

  ; Add each category to the category listview  
  Gui, ListView, SysListView321
  For index, category in categories
  {
    LV_Add("", category)
  }
  ; Autosize column
  LV_ModifyCol(1, 450) 

  ; Add each sound to the sounds listview
  Gui, ListView, SysListView322
  ; Add each sound to the listview
  For index, sound in sounds
  {
    ; remove categories from sound name
    sound_name := get_sound_name(sound)
    ; get all categories for current sound
    sound_categories := get_sound_categories(sound)
    ; Convert sound_categories array into a string
    sound_categories_string := ""
    For index2, sound_category in sound_categories
    {
      sound_categories_string .= ", " . sound_category
    }
    ; Purge leading comma from string
    sound_categories_string := StrReplace(sound_categories_string, ",","",, Limit := 1)
    ; Purge ] from string
    sound_categories_string := StrReplace(sound_categories_string, "]","")
    ; Add row to listview
    LV_Add("", sound_name, sound_categories_string, sound)
  }
  ; Autosize each column
  LV_ModifyCol(1, 350)
  LV_ModifyCol(2, 100)
  LV_ModifyCol(3, 1)

  ; Show the GUI
  Gui, Show, h612, Squishy's Soundboard
}

;----------------------------------------------------
;;;   Shows or hides the GUI
;----------------------------------------------------
gui_toggle() {
  if gui_state = pinned 
  {
    gui_state = hidden
    Gui, -AlwaysOnTop
    Gui, Minimize
  }
  else
  {
    gui_state = pinned
    Gui, +AlwaysOnTop
    Gui, Show
  }
}

;----------------------------------------------------
;;;   Handles a command being selected from dropdown
;----------------------------------------------------
handle_command_dropdown(){
  GuiControlGet, selected_command,,command_choice
  
  if selected_command = Clear Clipboard
  {
    Run, % A_ScriptDir . "\scripts\clear-clipboard.bat"
  }
  else if selected_command = Reload
  {
    Gui, Destroy
    Reload
  }
}

;----------------------------------------------------
;;;   Triggered when enter pressed in filter textfield
;----------------------------------------------------
handle_textfield_submit() {
  ; Focus on category listview
  Gui, ListView, SysListView321
  row_count := LV_GetCount()
  if(row_count = 1)
  {
    LV_GetText(category, 1, 1)
    play_random_sound(category)
  }

  ; If more than one category remaining, check individual files
  Gui, ListView, SysListView322
  row_count := LV_GetCount()
  if(row_count = 1)
  {
    LV_GetText(file, 1, 3)
    play_sound(A_ScriptDir . "\sounds\" . file . ".mp3")
    gui_toggle()
  }
}

;----------------------------------------------------
;;;   Filters the sounds in the ListView
;----------------------------------------------------
filter_sounds() {
  Gui, Submit, NoHide

  ; Split the user text apart at spaces so that 
  ; words don't have to be next to each other to be found
  user_input_slugs := StrSplit(user_category_text, " ")

  ; Array of categories that match the user slugs
  matched_categories := []
  matched_sounds := []

  ; Get all matched categories
  For index, category in categories
  {
    valid_category := true
    For j, slug in user_input_slugs
    {
      if !InStr(category, slug)
      {
        valid_category := false
        continue
      }
    }

    if(valid_category = false)
    {
      continue
    }
    matched_categories.push(category)
  }

  ; Get all matched individual sounds
  For index, sound in sounds
  {
    sound_slug := ""

    if include_category_when_filtering_specific_sounds = 0
    {
      sound_slug := get_sound_name(sound)
    }
    else 
    {
      sound_slug := sound
    }

    valid_sound := true
    For j, slug in user_input_slugs
    {
      if !InStr(sound_slug, slug)
      {
        valid_sound := false
        continue
      }
    }

    if(valid_sound = false)
    {
      continue
    }
  
    matched_sounds.push(sound)
  }

  ; Set focus on category listview
  Gui, ListView, SysListView321
  ; Remove all items
  LV_Delete()
  ; Add matched items only
  For index, category in matched_categories
  {
    LV_Add("", category)
  }
  ; Autosize columns
  LV_ModifyCol(1, 450)

  ; Set focus on individual listview
  Gui, ListView, SysListView322

  ; Remove all items
  LV_Delete()
  ; Add matched items only
  For index, sound in matched_sounds
  {
    ; remove categories from sound name
    sound_name := get_sound_name(sound)
    ; get all categories for current sound
    sound_categories := get_sound_categories(sound)
    ; Convert sound_categories array into a string
    sound_categories_string := ""
    For index2, sound_category in sound_categories  
    {
      sound_categories_string .= ", " . sound_category
    }
    ; Purge leading comma from string
    sound_categories_string := StrReplace(sound_categories_string, ",","",, Limit := 1)
    ; Purge ] from string
    sound_categories_string := StrReplace(sound_categories_string, "]","")
    ; Add row to listview
    LV_Add("", sound_name, sound_categories_string, sound)
  }
  ; Autosize columns
  LV_ModifyCol(1, 350)
  LV_ModifyCol(2, 100)
  LV_ModifyCol(3, 1)
}

;----------------------------------------------------
;;;   Handles the listview for sound categories
;----------------------------------------------------
handle_category_listview() {
  ; Force LV commands to use the appropriate listview
  Gui, ListView, SysListView321
  if (A_GuiEvent = "DoubleClick")
  {
    LV_GetText(RowText, A_EventInfo)
    play_random_sound(RowText)
    return
  }
}

;----------------------------------------------------
;;;   Handles the listview for the individual sounds
;----------------------------------------------------
handle_individual_listview() {
  Gui, ListView, SysListView322
  if (A_GuiEvent = "DoubleClick")
  {
    LV_GetText(RowText, A_EventInfo, 3)
    play_sound(A_ScriptDir . "\sounds\" . RowText . ".mp3")
    gui_toggle()
  }
}

;----------------------------------------------------
;;;   Returns a list of all mp3 sounds in /sounds folder
;----------------------------------------------------
get_all_sounds() {
  local sounds := {}
  Loop Files, sounds\*.mp3 
  {
    sounds.push(StrReplace(A_LoopFileName, ".mp3", ""))
  }

  return unique(sounds)
}

;----------------------------------------------------
;;;   Returns a list of all folders in /sounds
;----------------------------------------------------
get_all_categories() {
  local categories := []
  For i, sound in sounds
  {
    sound_categories := get_sound_categories(sound)
    if(sound_categories.Length() = 0) 
    {
      continue
    }
    For j, category In sound_categories 
    {
      categories.push(category)
    }
  }
  return unique(categories)
}

;----------------------------------------------------
;;;   Parses categories from a provided sound_name
;;;
;;;     * Categories are enclosed in [] and separated by commas in sound_name
;;;     * Categories should come at the end of the sound name.
;;;     ex. big moustache [naked gun, random].mp3
;----------------------------------------------------
get_sound_categories(sound_name) {
  local categories := []
  local sound_categories := StrSplit(sound_name, "[")
  if(sound_categories.Length() <= 1) 
  {
    return ""
  }
  split_categories := StrSplit(sound_categories[2], ",")
  if(split_categories.Length() = 0) 
  {
    return ""
  }
  For i, category in split_categories 
  {
    category := Trim(StrReplace(category, "]", ""))
    categories.push(category)
  }
  return categories
}

;----------------------------------------------------
;;;   Removes categories from a sound name
;----------------------------------------------------
get_sound_name(sound){
  sound_name_split := StrSplit(sound, "[")
  sound_name := sound_name_split[1]
  return sound_name
}

;----------------------------------------------------
;;;   Removes categories from a sound name
;----------------------------------------------------
get_sounds_in_category(requested_category) {
  category_sounds := []
  For i, sound in sounds
  {
    sound_categories := get_sound_categories(sound)
    For j, category In sound_categories 
    {
      if (category = requested_category) 
      {
        category_sounds.push(sound)
      }
    }
  }
  return category_sounds
}

;----------------------------------------------------
;;;   Plays a random sound from a provided category
;----------------------------------------------------
play_random_sound(category, toggle_gui = true) {
  category_sounds := get_sounds_in_category(category)

  if(category_sounds.Length() = 1)
  {
    random_index := 1
  }
  else
  {
    if(unplayed_sounds[category].Length() = 0 || !unplayed_sounds[category])
    {
      unplayed_sounds[category] := []
      For index in category_sounds 
      {
        unplayed_sounds[category].push(index)
      }
    }

    ; If there is only one sound for the category, just play it
    if(unplayed_sounds[category].Length() = 1) 
    {
      random_index := unplayed_sounds[category][1]
      unplayed_sounds[category].RemoveAt(1)
    } 
    else 
    {  
      Random, rand, 1, unplayed_sounds[category].Length()
      random_index := unplayed_sounds[category][rand] 
      unplayed_sounds[category].remove(rand)
    }
  }

  if(category_sounds[random_index] != "")
  {
    sound_path := A_ScriptDir . "\sounds\" . category_sounds[random_index] . ".mp3"
    play_sound(sound_path)
    if(toggle_gui == true)
    {
      gui_toggle()
    }
  }
}

;----------------------------------------------------
;;;   Plays sound provided by sound_path
;----------------------------------------------------
play_sound(sound_path) {
  if !FileExist(sound_path) 
  {
    return
  }
  stop_sound()
  Run "%vlc_path%" --aout=waveout --waveout-audio-device="%vlc_audio_out%" --play-and-exit --qt-start-minimized --qt-system-tray "%sound_path%",,,vlc_pid
}

;----------------------------------------------------
;;;   Stops the currently playing sound
;----------------------------------------------------
stop_sound() {
  oTrayInfo := TrayIcon_GetInfo("vlc.exe")
  TrayIcon_Remove(oTrayInfo[1].hWnd, oTrayInfo[1].uID)
  Process, Close, %vlc_pid%
}

;----------------------------------------------------
;;;   Intercepts second keyboard keystrokes
;----------------------------------------------------
KeyEvent(code, state) {
  ; Shows a tooltip with the code
  ; Useful for identifying the code of a key
	;ToolTip % "Keyboard Key - Code: " code ", State: " state

  ; Function should only fire when key down, not key up
  if(state == 1)
  {
    return
  }

  ; categories defined in SquishySoundboard.ahk
  categories := keymap[code]
  ; Pick a random category
  Random, rand, 1, categories.Length()

  if(categories[rand])
  {
    play_random_sound(categories[rand], false)
  }

  if gui_state = pinned 
  {
    gui_state = hidden
    Gui, -AlwaysOnTop
    Gui, Minimize
  }
}

;----------------------------------------------------
;;;   Intercepts second keyboard keystrokes
;----------------------------------------------------
keyboard_toggle()
{
  Gui, Submit, NoHide
  
  if(keyboard_vid != none && keyboard_pid != none)
  {
    if(intercept_keyboard = 1)
    {
      ; Initialize second keyboard
      keyboard_id := AHI.GetKeyboardId(keyboard_vid, keyboard_pid)
      AHI.SubscribeKeyboard(keyboard_id, true, Func("KeyEvent"))
    }
    else
    {
      AHI.UnsubscribeKeyboard(keyboard_id)
    }
  }
  else 
  {
    MsgBox, Nothing happened, as the keyboard_vid and/or keyboard_pid are not set in user_settings.ahk!
  }
}