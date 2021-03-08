; Created by Joshua Payette
; Built off the original project by Asger Juul Brunshøj at https://github.com/plul/Public-AutoHotKey-Scripts

;-------------------------------------------------------------------------------
;;; SOUNDBOARD ;;;
;-------------------------------------------------------------------------------




; ;-------------------------------------------------------------------------------
; ;;; SEARCH GOOGLE ;;;
; ;-------------------------------------------------------------------------------
; else if UserInput = g%A_Space% ; Search Google
; {
;     gui_search("Search Google", "https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=")
; }

; ;-------------------------------------------------------------------------------
; ;;; OPEN FOLDERS ;;;
; ;-------------------------------------------------------------------------------
; else if UserInput = down ; Downloads
; {
;     main_gui_destroy()
;     run C:\Users\%A_Username%\Downloads
; }
; else if UserInput = rec ; Recycle Bin
; {
;     main_gui_destroy()
;     Run ::{645FF040-5081-101B-9F08-00AA002F954E}
; }