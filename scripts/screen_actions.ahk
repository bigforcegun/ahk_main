#NoEnv
#Persistent,On
#SingleInstance,Force
#WinActivateForce
SetBatchLines,-1
SetWinDelay,0
SetKeyDelay,0
CoordMode,Mouse,Screen
EdgePixOffset := 5  
CornerPixOffset := 5  
SysGet, VirtualScreenWidth, 78
SysGet, VirtualScreenHeight, 79
 
SetTimer,WatchMouse,100
return

inZone = 0

WatchMouse:
MouseGetPos,x,y

  if (x < 0 + CornerPixOffset && y < 0 + CornerPixOffset){
	if(inZone = 0){
	 tooltip, LEFT TOP CORNER
	 Send,{LWin Down}{Tab}{LWin Up}
	}
	inZone = 1
  }
  else if (x < 0 + CornerPixOffset && y > VirtualScreenHeight - CornerPixOffset)
	tooltip, LEFT BOTTOM CORNER
  else if (x > VirtualScreenWidth - CornerPixOffset && y < 0 + CornerPixOffset)
    tooltip, RIGHT TOP CORNER
  else if (x > VirtualScreenWidth - CornerPixOffset && y > VirtualScreenHeight - CornerPixOffset)
    tooltip, RIGHT BOTTOM CORNER
  else if (x > VirtualScreenWidth - EdgePixOffset && y < VirtualScreenHeight - EdgePixOffset && y > 0 + EdgePixOffset)
    tooltip, RIGHT EDGE
  else if (x < 0 + EdgePixOffset && y > 0 + EdgePixOffset && y < VirtualScreenHeight - EdgePixOffset)
	tooltip, LEFT EDGE
  else if (x > 0 + EdgePixOffset && x < VirtualScreenWidth - EdgePixOffset && y < 0 + EdgePixOffset)
    tooltip, TOP EDGE	
  else if (x < VirtualScreenWidth - EdgePixOffset && x > 0 + EdgePixOffset && y > VirtualScreenHeight - EdgePixOffset)
    tooltip, BOTTOM EDGE	
  else{
	inZone = 0
	tooltip
  }
Return




;Loop
;{
;  MouseGetPos,mx,my
;	
;  If (mx=0)
;  {
;    If tabbed=0
;    {
;      ;Send, {LWin}{Tab}
;      ;	Send, {CapsLock}{Tab}
;	  
;	  ; Send,{LWln Down}{Tab}{LWln Up}
;	 
;      ; SetTimer,TAB,500
;    }
;    tabbed=1
;  }
;  Else
;  {
;    If tabbed=1
;    {
;      ;SetTimer,TAB,Off
;      ;Send,{Alt Up}
;      tabbed=0
;    }
;  }
;  Sleep,50
;}      

Return

