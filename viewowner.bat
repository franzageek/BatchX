@ECHO OFF
IF      "%~1"==""      GOTO Syntax
IF  /i  "%~1"=="--h"   GOTO Syntax
IF  /i  "%~1"=="-help" GOTO Syntax
IF  /i  "%~1"=="/?"    GOTO Syntax
ECHO.

 
:Start
SETLOCAL
 

SET OwnedFile=%1
IF NOT DEFINED OwnedFile   GOTO Syntax
SET OwnedFile=%OwnedFile:"=%
IF "%OwnedFile%"=="/?"     GOTO Syntax
IF NOT EXIST "%OwnedFile%" GOTO Syntax
IF EXIST "%OwnedFile%\"    GOTO Syntax
 

ECHO.%OwnedFile% | FIND "?" >NUL
IF NOT ERRORLEVEL 1 GOTO Multiple
ECHO.%OwnedFile% | FIND "*" >NUL
IF NOT ERRORLEVEL 1 GOTO Multiple
 

FOR /F "skip=5 tokens=4 delims= " %%A IN ('DIR/A-D/Q "%OwnedFile%" ^| FIND /V "(s)"') DO ECHO.%%A
ENDLOCAL
GOTO End
 
:Multiple

FOR /F "skip=5 tokens=4* delims= " %%A IN ('DIR/A-D/Q "%OwnedFile%" ^| FIND /V "(s)"') DO ECHO.%%A	%%B
ENDLOCAL
GOTO End

:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Display the owner of the specified file.
ECHO Usage: 
ECHO    $ %~n0  ^<filespec^>
ECHO.
ECHO ^<filespec^> should NOT be a directory name.
ECHO If ^<filespec^> contains wildcards, both the owners and
ECHO the file names will be displayed ^(tab delimited^)
ECHO.
:End
exit /b
 