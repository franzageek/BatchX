@ECHO OFF

IF      "%~1"==""      GOTO Syntax
IF  /i  "%~1"=="--h"   GOTO Syntax
IF  /i  "%~1"=="-help" GOTO Syntax
IF  /i  "%~1"=="/?"    GOTO Syntax
IF NOT  "%~2"==""      GOTO Syntax
 
SETLOCAL ENABLEDELAYEDEXPANSION
SET /A Num = %~1
SET Bin=
 
:Loop
SET /A "BinTmp = Num %% 2"
SET /A Num /= 2
SET Bin=%BinTmp%%Bin%
IF %Num% GTR 0 GOTO Loop
 
ECHO.%Bin%
 
ENDLOCAL
GOTO:EOF
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Convert the specified number to binary.
ECHO Usage: 
ECHO    $ %~nx0 number
ECHO.
ECHO Where:  number   is a decimal, hexadecimal or octal number
ECHO                  (0xnnn for hexadecimal, 0nnn for octal)
ECHO.
ECHO NOTE:   Non-numeric input will be treated as 0
ECHO.
exit /B