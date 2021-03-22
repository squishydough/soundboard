; Maintained by Josh Payette
; Built off of the original work by Asger Juul Brunshøj

#NoEnv                        ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn                       ; Enable warnings to assist with detecting common errors.
SendMode Input                ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%   ; Ensures a consistent starting directory.
#SingleInstance
SetCapsLockState, AlwaysOff

; User specific settings
#Include %A_ScriptDir%\user-settings.ahk

;-------------------------------------------------------
; Launch our GUI
;-------------------------------------------------------
gui_create()
return

;-------------------------------------------------------
; Script imports
;-------------------------------------------------------
; Misc utilities
#Include %A_ScriptDir%\scripts\utils.ahk
; TrayIcon library
#Include %A_ScriptDir%\scripts\trayicon.ahk
; Second keyboard interception script
#Include %A_ScriptDir%\scripts\AHI\Lib\AutoHotInterception.ahk
; Load the soundboard GUI
#Include %A_ScriptDir%\scripts\soundboard.ahk