@ECHO OFF
IF      "%~1"==""      GOTO Syntax
IF  /i  "%~1"=="--h"   GOTO Syntax
IF  /i  "%~1"=="-help" GOTO Syntax
IF  /i  "%~1"=="/?"    GOTO Syntax
IF NOT  "%~2"==""           GOTO Syntax
 
SETLOCAL ENABLEDELAYEDEXPANSION
SET /A Num = %~1
SET Oct=
 
:Loop
SET /A "OctTmp = Num %% 8"
SET /A Num /= 8
SET Oct=%OctTmp%%Oct%
IF %Num% GTR 0 GOTO Loop
 
ECHO.%Oct%
 
ENDLOCAL
GOTO:EOF
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Convert the specified number to octal.
ECHO Usage: 
ECHO    $ %~nx0 number
ECHO.
ECHO Where:  number   is a decimal or hexadecimal number
ECHO                  (0xnnn for hexadecimal)
ECHO.
ECHO NOTE:   Non-numeric input will be treated as 0
ECHO.
exit /B