@echo off
set "sourceDir=./AHK"
set "outputDir=../"
set "ahk2exe=./AHK/Ahk2Exe.exe"
set "base=./AHK/AutoHotkey64.exe"

for %%f in ("%sourceDir%\*.ahk") do (
  "%ahk2exe%" /in "%%f" /out "%outputDir%/%%~nf.exe" /base "%base%"
)
