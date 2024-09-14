CurrentDesktop := 1
Initilized := false

CapsLock:: {
  global CurrentDesktop, Initilized
  If (!Initilized) {
    Initilized := true
    Return Send("^#{Right}")
  }

  mapDesktopsFromRegistry()
  if (CurrentDesktop >= DesktopCount) {
    CurrentDesktop := 1
  } else {
    CurrentDesktop++
  }

  switchDesktopByNumber(CurrentDesktop)
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

switchDesktopByNumber(targetDesktop) {
  global CurrentDesktop
  if (CurrentDesktop == targetDesktop) {
    return
  }

  mapDesktopsFromRegistry()
  if (targetDesktop > DesktopCount or targetDesktop < 1) {
    OutputDebug("[invalid] target: " targetDesktop " current: " CurrentDesktop)
    return
  }

  SleepTime := 100
  TargetDiff := targetDesktop - CurrentDesktop
  if (TargetDiff != 0) {
    SleepTime := Round(100 / Max(TargetDiff, TargetDiff * -1))
  } 

  while (CurrentDesktop < targetDesktop) {
    Send("^#{Right}")
    Sleep(SleepTime)
    CurrentDesktop++
  }

  while (CurrentDesktop > targetDesktop) {
    Send("^#{Left}")
    Sleep(SleepTime)
    CurrentDesktop--
  }
}
