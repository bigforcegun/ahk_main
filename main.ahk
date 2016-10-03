#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv
#KeyHistory 100
#Persistent,On
#SingleInstance,Force


#Include %A_ScriptDir%\lib
#Include %A_ScriptDir%\scripts\screen_actions.ahk
#Include %A_ScriptDir%\scripts\music_actions.ahk
#Include %A_ScriptDir%\scripts\run_actions.ahk


; keyboard break keys changes
F1::Send {LWin}
*CapsLock::Send {LWin Down}
*CapsLock Up::Send {LWin Up}






Return
