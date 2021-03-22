;-------------------------------------------------------
; User specific values
;-------------------------------------------------------
; Location of your VLC Executable
global vlc_path := "C:\Program Files\VideoLAN\VLC\vlc.exe"
; Voicemeeter Audio Out device as specified in VLC
; See README.md for help getting this valuie
global vlc_audio_out := ""
; Whether intercept keyboard is toggled off (0) or on (1) by default
global intercept_keyboard := 0
; Keyboard vid/pid for your second keyboard
; See README.md for help getting these values
global keyboard_vid = none
global keyboard_pid = none
;----------------------------------------------------------------------
; Keymap for categories to specific keys on the second keyboard
; IGNORE SPACER properties - just there for readability
;
; Examples:
;
; the 1 key on the second keyboard will randomize multiple categories
; 2: ["insult", "joke"]
;
; the 1 key on the second keyboard will randomize a single category
; 2: ["insult"]
;----------------------------------------------------------------------
global keymap := {spacer: ""
; Key: 1
, 2: []
; Key: 2
, 3: []
; Key: 3
, 4: []
; Key: 4
, 5: []
; Key: 5
, 6: []
; Key: 6
, 7: []
; Key: 7
, 8: []
; Key: 8
, 9: []
; Key: 9
, 10: []
; Key: 0
, 11: []
; Key: minus
, 12: []
; Key: equals
, 13: []
; Key: Q
, 16: []
; Key: W
, 17: []
; Key: E
, 18: []
; Key: R
, 19: []
; Key: T
, 20: []
; Key: Y
, 21: []
; Key: U
, 22: []
; Key: I
, 23: []
; Key: O
, 24: []
; Key: P
, 25: []
; Key: [
, 26: []
; Key: ]
, 27: []
; Key: A
, 30: []
; Key: S
, 31: []
; Key: D
, 32: []
; Key: F
, 33: []
; Key: G
, 34: []
; Key: H
, 35: []
; Key: J
, 36: []
; Key: K
, 37: []
; Key: L
, 38: []
; Key: semicolon
, 39: []
; Key: single quote
, 40: []
; Key: Z
, 44: []
; Key: X
, 45: []
; Key: C
, 46: []
; Key: V
, 47: []
; Key: B
, 48: []
; Key: N
, 49: []
; Key: M
, 50: []
; Key: comma
, 51: []
; Key: period
, 52: []
; Key: front slash
, 53: []
; Key: spacebar
, 57: []
; Key: F1
, 59: []
; Key: F2
, 60: []
; Key: F3
, 61: []
; Key: F4
, 62: []
; Key: F5
, 63: []
; Key: F6
, 64: []
; Key: F7
, 65: []
; Key: F8
, 66: []
; Key: F9
, 67: []
; Key: F10
, 68: []
; Key: Num7
, 71: []
; Key: Num8
, 72: []
; Key: Num9
, 73: []
; Key: Num4
, 75: []
; Key: Num5
, 76: []
; Key: Num6
, 77: []
; Key: Num1
, 79: []
; Key: Num2
, 80: []
; Key: Num3
, 81: []
; Key: F11
, 87: []
; Key: F12
, 88: []
; ignore this property - included just for readability
, spacer2: ""}