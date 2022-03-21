@ECHO OFF
ECHO.
 
IF /i [%1]==[--h] GOTO Syntax
IF /i [%1]==[-help] GOTO Syntax
IF /i [%1]==[/?] GOTO Syntax
IF NOT [%1]==[] GOTO Syntax

REGEDIT /E %TEMP%.\DefPRN.dat "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows"

FOR /F "tokens=2 delims=,=" %%A IN ('TYPE %TEMP%.\DefPRN.dat ^| FIND "Device"') DO SET DefPRN=%%A

DEL %TEMP%.\DefPRN.dat

SET DefPRN=%DefPRN:"=%
SET DefPRN
 

GOTO End
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Display the default printer name.
ECHO Usage: 
ECHO    $ %~nx0
ECHO.
exit /b
 