;-------------------------------------------------------
; User specific values
;-------------------------------------------------------
; Location of your VLC Executable
global vlc_path := "C:\Program Files\VideoLAN\VLC\vlc.exe"
; Voicemeeter Audio Out device as specified in VLC
; See README.md for help getting this valuie
global vlc_audio_out := "Music (VB-Audio Cable A) ($1,$64)"
; Whether intercept keyboard checkbox is toggled off (0) or on (1) by default
global intercept_keyboard := 1
; Whether the checkbox is toggled off (0) or on (1) by default
global include_category_when_filtering_specific_sounds := 1
; Keyboard vid/pid for your second keyboard
; See README.md for help getting these values
global keyboard_vid = 0x04CA
global keyboard_pid = 0x0022
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
, 16: ["death"]
; Key: W
, 17: ["hello"]
; Key: E
, 18: ["bye"]
; Key: R
, 19: ["belittle"]
; Key: T
, 20: ["taunt"]
; Key: Y
, 21: ["insult"]
; Key: U
, 22: []
; Key: I
, 23: []
; Key: O
, 24: []
; Key: P
, 25: ["smau"]
; Key: [
, 26: []
; Key: ]
, 27: []
; Key: A
, 30: []
; Key: S
, 31: ["confused"]
; Key: D
, 32: ["okay"]
; Key: F
, 33: ["fun"]
; Key: G
, 34: ["command"]
; Key: H
, 35: ["ouch"]
; Key: J
, 36: ["oops"]
; Key: K
, 37: ["stop"]
; Key: L
, 38: ["thanks"]
; Key: semicolon
, 39: []
; Key: single quote
, 40: ["threat"]
; Key: Z
, 44: ["agree", "yes"]
; Key: X
, 45: ["disagree", "no"]
; Key: C
, 46: ["yes", "agree"]
; Key: V
, 47: ["no", "disagree"]
; Key: B
, 48: ["understood"]
; Key: N
, 49: ["sorry"]
; Key: M
, 50: ["cheer"]
; Key: comma
, 51: ["self deprecation"]
; Key: period
, 52: ["random"]
; Key: front slash
, 53: ["rage"]
; Key: spacebar
, 57: ["boast"]
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