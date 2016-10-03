; ===========================================================================
; Run a program or switch to it if already running.
;    Target - Program to run. E.g. Calc.exe or C:\Progs\Bobo.exe
;    WinTitle - Optional title of the window to activate.  Programs like
;    MS Outlook might have multiple windows open (main window and email
;    windows).  This parm allows activating a specific window.
; ===========================================================================

;RunOrActivate(Target, WinTitle = "", Parameters = "")
RunOrActivate(WorkingRir,Target, WinTitle = "", Parameters = "")
{
   ;SetWorkingDir WorkingRir
   ; Get the filename without a path
   SplitPath, Target, TargetNameOnly
	 
    IfWinActive, %WinTitle%
     {
     Run %Target%
     Return
     }
	 
   Process, Exist, %TargetNameOnly%
   If ErrorLevel > 0
      PID = %ErrorLevel%
   Else
      Run, %Target% %Parameters%, %WorkingRir%, , PID

   ; At least one app (Seapine TestTrack wouldn't always become the active
   ; window after using Run), so we always force a window activate.
   ; Activate by title if given, otherwise use PID.
   If WinTitle <>
   {
      SetTitleMatchMode, 2
      WinWait, %WinTitle%, , 3
      ;TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
      WinActivate, %WinTitle%
   }
   Else
   {
      WinWait, ahk_pid %PID%, , 3
      ;TrayTip, , Activating PID %PID% (%TargetNameOnly%)
      WinActivate, ahk_pid %PID%
   }


   ;SetTimer, RunOrActivateTrayTipOff, 1
   ;SetWorkingDir %A_WorkingDir%
}

; Turn off the tray tip
RunOrActivateTrayTipOff:
   SetTimer, RunOrActivateTrayTipOff, off
   TrayTip
Return

;example to run or activate the specific script, "Autohotkey"
;^!+a::RunorActivate("notepad.exe", "AutoHotkey", "C:\Documents and Settings\ahoover.autotool\My Documents\AutoHotkey.ahk")
#;::RunOrActivate("C:\Program Files\Mozilla Firefox\firefox.exe", "Mozilla Firefox", "")