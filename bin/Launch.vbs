Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """cmd.exe"" /c", 0
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """E:\!#SYSTEM\.ahk-macro\bin\Macro.exe""", 0
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """E:\!#SYSTEM\.ahk-macro\bin\VirtualDesktop-W10.exe""", 0
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """C:\Program Files (x86)\FastStone Capture\FSCapture.exe"" -Silent", 0
Set WshShell = Nothing

Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """E:\!#SYSTEM\.ahk-macro\bin\nircmdc.exe"" loop 999999 1000 setsysvolume 65536 default_record", 0
Set WshShell = Nothing