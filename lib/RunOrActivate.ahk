; ===========================================================================
; Run a program or switch to it if already running.
;    Target - Program to run. E.g. Calc.exe or C:\Progs\Bobo.exe
;    WinTitle - Optional title of the window to activate.  Programs like
;    MS Outlook might have multiple windows open (main window and email
;    windows).  This parm allows activating a specific window.
; ===========================================================================


TrayDebug(Message)
{
	;TrayTip, , %Message%
}

;RunOrActivate(Target, WinTitle = "", Parameters = "")
RunOrActivate(WorkingRir,Target, WinTitle = "", Parameters = "",TitleMatchMode = 2)
{
   ;SetWorkingDir WorkingRir
   ;Get the filename without a path
	SplitPath, Target, TargetNameOnly
	 
	;IfWinActive, %WinTitle% 
	;{
	;	TrayTip, , WTF "%WinTitle%" (%TargetNameOnly%)
	;	Run %Target%
	;	Return
	;}
	 
	 
	Process, Exist, %TargetNameOnly%
	If ErrorLevel > 0
	{
		PID = %ErrorLevel%
		Msg = FOUND PID FOR "%WinTitle%" (%TargetNameOnly%)
		TrayDebug(Msg)
	}
	Else
	{
		Msg = TRY TO RUN "%WinTitle%" (%TargetNameOnly%)
		TrayDebug(Msg)
		Run, %Target% %Parameters%, %WorkingRir%, , PID
	}

	; At least one app (Seapine TestTrack wouldn't always become the active
	; window after using Run), so we always force a window activate.
	; Activate by title if given, otherwise use PID.
	If WinTitle <>
	{
		SetTitleMatchMode, %TitleMatchMode%
		
		IfWinNotExist %WinTitle%
		{
			Msg = Show And Activate By Title "%WinTitle%" (%TargetNameOnly%)
			WinShow, %WinTitle%
		}
		Else
		{
			Msg =  Activate By Title "%WinTitle%" (%TargetNameOnly%)
		}
		TrayDebug(Msg)
		WinWait, %WinTitle%, , 3
		WinActivate, %WinTitle%
		
	
		;IfWinActive, %WinTitle%
		;	WinActivateBottom, %WinTitle%
		;Else
				
	}
	Else
	{
		IfWinNotExist ahk_pid %PID%
		{
			Msg = Show And Activate By PID "%WinTitle%" (%TargetNameOnly%)
			WinShow, ahk_pid %PID%
		}
		Else
		{
			Msg =  Activate By PID "%WinTitle%" (%TargetNameOnly%)
		}
		TrayDebug(Msg)
		WinWait, ahk_pid %PID%, , 3
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