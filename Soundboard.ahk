; Maintained by Josh Payette
; Built off of the original work by Asger Juul Brunshøj

#NoEnv                        ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                         ; Enable warnings to assist with detecting common errors.
SendMode Input                ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%   ; Ensures a consistent starting directory.
#SingleInstance
SetCapsLockState, AlwaysOff
;-------------------------------------------------------
; Launch our GUI
;-------------------------------------------------------
gui_create()
return
;-------------------------------------------------------
; Misc utilities
#Include %A_ScriptDir%\scripts\utils.ahk
; TrayIcon library
#Include %A_ScriptDir%\scripts\trayicon.ahk
; Load the soundboard GUI
#Include %A_ScriptDir%\scripts\soundboard.ahk