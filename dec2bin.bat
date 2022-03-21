@ECHO OFF
IF /i "%~1"=="-help" GOTO Syntax
IF /i "%~1"=="--h" GOTO Syntax
IF /i "%~1"=="/?" GOTO Syntax
SETLOCAL
SET /A Decimal = %1 +0 >NUL 2>&1 || GOTO Syntax
IF %Decimal% LSS 0 GOTO Syntax
 
SET Binary=
SET Scratch=%Decimal%
 
:Loop
SET /A "LSB = %Scratch% %% 2"
SET /A "Scratch = %Scratch% >> 1"
SET Binary=%LSB%%Binary%
IF NOT %Scratch% EQU 0 GOTO Loop
 
SET Decimal
SET Binary
 
ENDLOCAL
EXIT /B
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Convert a decimal number to a binary value.
ECHO Usage: 
ECHO    $ %~nx0 decimal_number
ECHO.
ECHO Where:  decimal_number    is a 32-bit positive integer or calculation
ECHO                           (0..2,147,483,647 or 0..017777777777)
ECHO.
ECHO NOTE:   This batch file uses CMD.EXE's internal commands only.
ECHO         Return code ("ErrorLevel") 0 if conversion was successful,
ECHO         otherwise 1.
ECHO.
ENDLOCAL
EXIT /B 1