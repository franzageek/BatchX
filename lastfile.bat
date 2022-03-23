@ECHO OFF

IF NOT "%1" == "" goto :Syntax

PUSHD %UserProfile%\Recent
FOR /F "tokens=*" %%A IN ('DIR /B /OD') DO SET LastFile=%%~fA
POPD
START "Most recently used file" "%LastFile%"

:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Opens the last file used in Documents folder.
ECHO Usage: 
ECHO    $ %~nx0
ECHO.
exit /b
