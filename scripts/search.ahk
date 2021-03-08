;-------------------------------------------------------------------------------
; SEARCH ENGINES
;-------------------------------------------------------------------------------

gui_search(search_title, url) {
    global
    if main_gui_state != search
    {
        main_gui_state = search
        ; if main_gui_state is "main", then we are coming from the main window and
        ; GUI elements for the search field have not yet been added.
        Gui, Add, Text, %gui_control_options% %cYellow%, %search_title%
        Gui, Add, Edit, %gui_control_options% %cYellow% vgui_SearchEdit -WantReturn
        Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter ; hidden button
        GuiControl, Disable, UserInput
        Gui, Show, AutoSize
    }

    ; Assign the url to a variable.
    ; The variables will have names search_url1, search_url2, ...

    search_urls := search_urls + 1
    search_url%search_urls% := url
}

gui_SearchEnter:
    Gui, Submit
    gui_destroy()
    query_safe := uriEncode(gui_SearchEdit)
    Loop, %search_urls%
    {
        StringReplace, search_final_url, search_url%A_Index%, REPLACEME, %query_safe%
        run %search_final_url%
    }
    search_urls := 0
    return