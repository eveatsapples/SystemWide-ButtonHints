#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#Persistent

; z::
; WinGet, controls, ControlList, A
; Msgbox % controls
; Return
KeyHintKeys := ["f", "j", "d", "k", "s", "l", "a", "m", "c", "n", "v", "b", "u", "r", "i", "e", "o", "w", "y", "t"]

f::
  buttonPositions := ShowToolTips()
  getInput(buttonPositions)
  Return

ShowToolTips() {
  ID := WinExist( "A" )
  Global KeyHintKeys

  WinGet, Clist, ControlList, ahk_id %ID%
  
  currentKeyIndex := 0

  controlsIndex := []

  i := 1
  Loop, Parse, CList, `n
  {

    currentKey := keyHintKeys[currentKeyIndex]

    ClassNN := A_LoopField

    ControlGetPos, X, Y, W, H, %ClassNN%, ahk_id %ID%

    Controls := ClassNN "`t" X "," Y " - " W "," H "`n"

    ToolTip, %currentKey%, X, Y, i
    
    controlsIndex.Push(Controls)

    i := i + 1
    currentKeyIndex := currentKeyIndex + 1
  }
  SetTimer, RemoveToolTips, -5000
  ; MsgBox, % Controls
  Return controlsIndex
}

on := 0
GetInput(controls) {
  button := ""
  i := 1
  Global on := 0
  while(on = 0) {
    if(i < 21) {
      i := 1
    }
    button := controls[i]
    if GetKeyState(button) {
      on := 1
      ControlClick, button
    }
    Sleep, 1
    i := i + 1
  }
  Return
}

sc027::RemoveToolTips()

RemoveToolTips:
Global on
on := 1
RemoveToolTips()
Return

RemoveToolTips() {
  i := 1
  Loop, 20
  {
    ToolTip,,,,i
    i := i + 1
  }
  return
}

w::ShowUnderMouse()

ShowUnderMouse() {
  Loop
  {
    Sleep, 100
    MouseGetPos, , , WhichWindow, WhichControl
    ControlGetPos, x, y, w, h, %WhichControl%, ahk_id %WhichWindow%
    ToolTip, %WhichControl%`nX%X%`tY%Y%`nW%W%`t%H%
  }
  Return
}

q::
ExitApp
