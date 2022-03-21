@ECHO OFF
IF /i "%~1"=="-help" GOTO Syntax
IF /i "%~1"=="--h" GOTO Syntax
IF /i "%~1"=="/?" GOTO Syntax
SETLOCAL ENABLEDELAYEDEXPANSION
SET /A Decimal = %1 +0 >NUL 2>&1 || GOTO Syntax
IF %Decimal% LSS 0 GOTO Syntax
 
SET Convert=0123456789ABCDEF
SET Hexadecimal=
SET Scratch=%Decimal%
 
:Loop
SET /A LSB = %Scratch% %% 16
SET /A "Scratch = %Scratch% >> 4"
SET Hexadecimal=!Convert:~%LSB%,1!%Hexadecimal%
IF NOT %Scratch% EQU 0 GOTO Loop
 
SET Hexadecimal=0x%Hexadecimal%
 
SET Decimal
SET Hexadecimal
 
SET RC=0
IF NOT %Decimal% EQU %Hexadecimal% (
	ECHO An error occurred, %Hexadecimal% is not equal to %Decimal%
	SET RC=1
)
ENDLOCAL & EXIT /B %RC%
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Convert a decimal number to hexadecimal.
ECHO Usage: 
ECHO    $ %~nx0 decimal_number
ECHO.
ECHO Where:  decimal_number    is a 32-bit positive integer or calculation
ECHO                           (0..2,147,483,647 or 0x00000000..0x7FFFFFFF)
ECHO.
ECHO NOTE:   This batch file uses CMD.EXE's internal commands only.
ECHO         Return code ("ErrorLevel") 0 if conversion was successful,
ECHO         otherwise 1.
ECHO.
ENDLOCAL
EXIT /B 1