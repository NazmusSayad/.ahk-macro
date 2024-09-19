Initilized := false
!CapsLock:: {
  global Initilized
  if (!Initilized) {
    Initilized := true
    Return Send("^#{Right}")
  }

  global CurrentDesktop
  mapDesktopsFromRegistry()

  if (CurrentDesktop >= DesktopCount) {
    CurrentDesktop := 1
  } else {
    CurrentDesktop++
  }

  Return switchDesktopByNumber(CurrentDesktop)
}

mapDesktopsFromRegistry() {
  global DesktopCount, CurrentDesktop
  DesktopCount := 1

  IdLength := 32
  SessionId := getSessionId()
  if (SessionId) {
    CurrentDesktopId := RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\" SessionId "\VirtualDesktops",
    "CurrentVirtualDesktop")
    if (CurrentDesktopId) {
      IdLength := StrLen(CurrentDesktopId)
    }
  }

  DesktopList := RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops",
  "VirtualDesktopIDs")
  if (DesktopList) {
    DesktopListLength := StrLen(DesktopList)
    DesktopCount := DesktopListLength / IdLength
  }

  i := 0
  while (CurrentDesktopId and i < DesktopCount) {
    StartPos := (i * IdLength) + 1
    DesktopIter := SubStr(DesktopList, StartPos, IdLength)
    if (DesktopIter = CurrentDesktopId) {
      CurrentDesktop := i + 1
      break
    }
    i++
  }
}

getSessionId() {
  ProcessId := DllCall("GetCurrentProcessId", "UInt")
  if (ProcessId = 0) {
    OutputDebug("Error getting current process id.")
    return 0
  }
  SessionId := 0
  Result := DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", &SessionId)
  if (Result = 0) {
    OutputDebug("Error getting session id.")
    return 0
  }
  return SessionId
}

switchDesktopByNumber(TargetDesktop) {
  global CurrentDesktop
  mapDesktopsFromRegistry()

  if (TargetDesktop > DesktopCount or TargetDesktop < 1) {
    OutputDebug("[invalid] target: " TargetDesktop " current: " CurrentDesktop)
    return
  }

  SleepTime := 100
  TargetDiff := TargetDesktop - CurrentDesktop
  if (TargetDiff != 0) {
    SleepTime := Round(100 / Max(TargetDiff, TargetDiff * -1, 1))
  } 

  while (CurrentDesktop < TargetDesktop) {
    Send "^#{Right}"
    Sleep(SleepTime)
    CurrentDesktop++
  }

  while (CurrentDesktop > TargetDesktop) {
    Send "^#{Left}"
    Sleep(SleepTime)
    CurrentDesktop--
  }
}
