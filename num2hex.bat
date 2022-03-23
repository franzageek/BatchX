@ECHO OFF
IF      "%~1"==""      GOTO Syntax
IF  /i  "%~1"=="--h"   GOTO Syntax
IF  /i  "%~1"=="-help" GOTO Syntax
IF  /i  "%~1"=="/?"    GOTO Syntax
IF NOT  "%~2"==""           GOTO Syntax
 
SETLOCAL ENABLEDELAYEDEXPANSION
SET /A Num = %~1
SET Hex=
SET Hex.10=A
SET Hex.11=B
SET Hex.12=C
SET Hex.13=D
SET Hex.14=E
SET Hex.15=F
 
:Loop
SET /A "HexTmp = Num %% 16"
IF %HexTmp% GTR 9 SET HexTmp=!Hex.%HexTmp%!
SET /A Num /= 16
SET Hex=%HexTmp%%Hex%
IF %Num% GTR 0 GOTO Loop
 
ECHO.%Hex%
 
ENDLOCAL
GOTO:EOF
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Convert the specified number to hexadecimal.
ECHO Usage: 
ECHO    $ %~nx0 number
ECHO.
ECHO Where:  number   is a decimal or octal number
ECHO                  (0nnn for octal)
ECHO.
ECHO NOTE:   Non-numeric input will be treated as 0
ECHO.
exit /B
