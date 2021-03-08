global main_gui_state := closed

main_gui_autoexecute:
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
  gui_control_options := "xm w220 " . cForeground . " -E0x200"
  ; Initialize variable to keep track of the state of the GUI
  main_gui_state = closed
  return

;-------------------------------------------------------------------------------
; LAUNCH GUI
;-------------------------------------------------------------------------------
CapsLock & Space::
  ; If the GUI is already open, close it.
  if main_gui_state != closed
  {
    main_gui_destroy()
    return
  }
  main_gui_state = open
  Gui, Margin, 16, 16
  Gui, Color, 1d1f21, 282a2e
  Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border
  Gui, Font, s11, Segoe UI
  Gui, Add, Text, %gui_control_options% vgui_main_title, ¯\_(ツ)_/¯
  Gui, Font, s10, Segoe UI
  Gui, Add, Edit, %gui_control_options% vmain_user_input gmain_handle_user_input
  Gui, Show,, mainGUI
  return

;-------------------------------------------------------------------------------
; GUI FUNCTIONS AND SUBROUTINES
;-------------------------------------------------------------------------------
; Automatically triggered on Escape key:
GuiEscape:
    main_gui_destroy()
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

; The callback function when the text changes in the input field.
main_handle_user_input:
  Gui, Submit, NoHide
  
  ; Reload this script
  if main_user_input = rel
  {
    main_gui_destroy()
    Reload
  }
  ; Stop currently playing sound
  else if main_user_input = stop
  {
    sb_stop_sound()
  }
  ; Show soundboard gui
  else if main_user_input = sb
  {
    sb_gui_create()
  }
  return

; Destroy the GUI after use.
#WinActivateForce
main_gui_destroy() {
  main_gui_state = closed
  ; Clear the tooltip
  ToolTip
  ; Hide GUI
  Gui, Destroy
  ; Bring focus back to another window found on the desktop
  WinActivate
}