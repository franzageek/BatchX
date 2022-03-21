@ECHO OFF
IF      "%~1"==""      GOTO Syntax
IF  /i  "%~1"=="--h"   GOTO Syntax
IF  /i  "%~1"=="-help" GOTO Syntax
IF  /i  "%~1"=="/?"    GOTO Syntax

SETLOCAL
 

IF [%1]==[] GOTO Syntax
ECHO.%* | FIND "=" >NUL
IF NOT ERRORLEVEL 1 GOTO Syntax
 

SET REVERSE=
SET INPUT=%*

VER | FIND "Windows NT" >NUL
IF NOT ERRORLEVEL 1 SET INPUT=%INPUT:~1%
 
:Loop

IF NOT DEFINED INPUT GOTO Finish

SET FIRSTCHAR=%INPUT:~0,1%
SET INPUT=%INPUT:~1%

SET REVERSE=%FIRSTCHAR%%REVERSE%

GOTO Loop
 

ECHO.

VER | FIND "Windows NT" >NUL
IF ERRORLEVEL 1 (ECHO Input string   = %*) ELSE (ECHO Input string   =%*)
ECHO Reverse string = %REVERSE%
GOTO End
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Return the specified string in the reverse order.
ECHO Usage: 
ECHO    $ %~n0  ^<string^>
ECHO.
ECHO ^<string^> cannot contain equal signs ("=")
ECHO.
ECHO Example:
ECHO    $ %~n0  Hello everyone
ECHO.
ECHO returns:
ECHO Input string   = Hello everyone
ECHO Reverse string = enoyreve olleH

:End
ENDLOCAL
exit /b
 