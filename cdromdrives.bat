@ECHO OFF

IF NOT  "%~1"=="" GOTO Syntax
 
MOUNTVOL /R
 

FOR /F "tokens=2 delims=\ " %%A IN ('REG Query "HKLM\SYSTEM\MountedDevices" /v "\DosDevices\*" ^| FINDSTR /R /E /C:" 5C[0-9A-F]*"') DO ECHO.%%A
GOTO :EOF
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : List all CDROM drives for the local computer.
ECHO Usage: 
ECHO    $ %~nx0
ECHO.
exit /b