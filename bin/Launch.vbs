Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """cmd.exe"" ""/c""", 0
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """E:\!-SYSTEM-!\.ahk-macro\bin\Macro.exe"""
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """E:\!-SYSTEM-!\.ahk-macro\bin\VirtualDesktop.exe"""
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """C:\Program Files (x86)\FastStone Capture\FSCapture.exe"" ""-Silent"""
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "netserv ftp --root E:/!-SYSTEM-!/DriveSymLinks --port 55555 --password 2122 --username sayad", 0
Set WshShell = Nothing