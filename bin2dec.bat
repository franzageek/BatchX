@ECHO OFF
IF    "%~1"=="" GOTO Syntax
IF /i    "%~1"=="--h" GOTO Syntax
IF /i     "%~1"=="--help" GOTO Syntax
IF     "%~1"=="/?" GOTO Syntax
IF NOT "%~2"=="" GOTO Syntax
ECHO "%~1"| FINDSTR /R /B /C:"\"[01][01]*\"$" >NUL || GOTO Syntax
 
SET Binary=%~1
SET Decimal=0
SET DigVal=1
 
SET Binary
 
:Loop
IF %Binary% GTR 1 (
	SET Digit=%Binary:~-1%
	SET Binary=%Binary:~0,-1%
) ELSE (
	SET /A Digit = %Binary%
	SET Binary=0
)

IF %Digit% EQU 1 SET /A Decimal = %Decimal% + %DigVal%

SET /A DigVal *= 2

IF %Binary% GTR 0 GOTO Loop
 

SET Binary=
SET Digit=
SET DigVal=
 

SET Decimal
 

EXIT /B %Decimal%
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Convert a binary value to a decimal number.
ECHO Usage: 
ECHO    $  %~nx0 binary_number
ECHO.
ECHO Where:  "binary_number"  is the binary number to be converted
ECHO                          (zeroes and ones only, no prefix nor suffix)
ECHO.
ECHO Notes:  The binary number and the decimal result are displayed as text on
ECHO         screen, and the decimal number is stored in an environment variable
ECHO         named "Decimal", and returned as "errorlevel" (return code); this
ECHO         means errorlevel 0 could mean decimal result 0 or a syntax error.
ECHO.
EXIT /b