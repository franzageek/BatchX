@ECHO OFF
IF NOT "%~1"=="" GOTO Syntax
IF /i "%~1"=="-help" GOTO Syntax
IF /i "%~1"=="--h" GOTO Syntax
IF /i "%~1"=="/?" GOTO Syntax
 

REG.EXE Query HKLM\SYSTEM\ControlSet001\Control\MiniNT >NUL 2>&1
IF NOT ERRORLEVEL 1 (
	ECHO Windows PE
	EXIT /B 3
)
 
WMIC.EXE Path Win32_ComputerSystem Get BootupState | FIND.EXE "Normal boot" >NUL
IF NOT ERRORLEVEL 1 (
	ECHO Normal
	EXIT /B 0
)
 
WMIC.EXE Path Win32_ComputerSystem Get BootupState | FIND.EXE "Fail-safe boot" >NUL
IF NOT ERRORLEVEL 1 (
	ECHO Safe mode
	EXIT /B 1
)
 
WMIC.EXE Path Win32_ComputerSystem Get BootupState | FIND.EXE "Fail-safe with network boot" >NUL
IF NOT ERRORLEVEL 1 (
	ECHO Safe mode with network
	EXIT /B 2
)
 
ECHO Unknown
EXIT /B -1
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Display the boot state (normal, safe mode, WinPE ecc.)
ECHO Usage: 
ECHO    $ %~nx0
ECHO.
ECHO NOTE:    Boot state is returned as string and as "errorlevel" ^(return code^):
ECHO               "Normal"                    ^(errorlevel = 0^)
ECHO               "Safe mode"                 ^(errorlevel = 1^)
ECHO               "Safe mode with network"    ^(errorlevel = 2^)
ECHO               "Windows PE"                ^(errorlevel = 3^)
ECHO           In case of ^(command line^) errors, the errorlevel will be -1.
EXIT /B -1
 
