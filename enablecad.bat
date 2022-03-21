@echo off
IF /i [%1]==[--h] GOTO Syntax
IF /i [%1]==[-help] GOTO Syntax
IF /i [%1]==[/?] GOTO Syntax
IF /i [%1]==[/E] GOTO Enable
IF /i [%1]==[/D] GOTO Disable

:Enable
REG Add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DisableCAD /t REG_DWORD /d 0
exit /b

:Disable
REG Add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DisableCAD /t REG_DWORD /d 1
exit /b

:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Enable the CTRL+ALT+DEL feature to unlock the PC at the logon screen.
ECHO Usage: 
ECHO    $ %~nx0 [ /E ^| /D ]
ECHO.
ECHO Where:      /E   Enable CTRL+ALT+DEL
ECHO             /D   Disable CTRL+ALT+DEL
exit /b