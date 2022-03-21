@ECHO OFF

IF /i [%1]==[--h] GOTO Syntax
IF /i [%1]==[-help] GOTO Syntax
IF /i [%1]==[/?] GOTO Syntax
 
WMIC.EXE /? >NUL 2>&1 || GOTO Syntax
 
SETLOCAL ENABLEDELAYEDEXPANSION
 
IF NOT "%~2"=="" GOTO Syntax
 
SET AcceptDriveTypes=0
SET Numeric=0
IF /I "%~1"==""   SET AcceptDriveTypes=23456
IF /I "%~1"=="/C" SET AcceptDriveTypes=5
IF /I "%~1"=="/F" SET AcceptDriveTypes=3
IF /I "%~1"=="/L" SET AcceptDriveTypes=2356
IF /I "%~1"=="/N" SET AcceptDriveTypes=4
IF /I "%~1"=="/R" SET AcceptDriveTypes=25
IF /I "%~1"=="/T" SET AcceptDriveTypes=23456
IF /I "%~1"=="/T" SET Numeric=1
IF %AcceptDriveTypes% EQU 0 (
	SET Arg=%~1
	IF /I "!Arg:~0,3!"=="/T:" (
		REM *** Add 1 as prefix, and remove it again, to
		REM *** prevent interpretation of leading zero as octal
		SET /A AcceptDriveTypes = 1!Arg:~3!
		SET AcceptDriveTypes=!AcceptDriveTypes:~1!
		SET Numeric=1
	)
)
 

IF %AcceptDriveTypes% EQU 0 (
	ENDLOCAL
	GOTO Syntax
)
 

FOR /F "tokens=2,3* delims=," %%A IN ('WMIC.EXE /Node:"%Node%" /Output:STDOUT Path Win32_LogicalDisk Get DeviceID^,Description^,DriveType /Format:CSV ^| FINDSTR /R /C:",[A-Z]:"') DO (
	REM Add an extra FOR loop to remove the linefeed from %%C
	FOR %%D IN (%%C) DO (
		ECHO.%AcceptDriveTypes% | FIND "%%~D" >NUL
		IF NOT ERRORLEVEL 1 (
			IF %Numeric% EQU 1 (
				ECHO.  %%B      %%C
			) ELSE (
				ECHO.  %%B      %%A
			)
		)
	)
)
 

ENDLOCAL
GOTO:EOF
 
 
:Syntax
SET AcceptDriveTypes=
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Display the default printer name.
ECHO Usage: 
ECHO    $ %~nx0 [ /C ^| /F ^| /N ^| /R ]
ECHO.
ECHO Where:  /C      displays only CD-ROM drives
ECHO         /F      displays only Fixed disk drives
ECHO         /L      displays only Local disk drives ^(including removables^)
ECHO         /N      displays only Network drives
ECHO         /R      displays only Removable drives  ^(including CD-ROMs^)
ECHO         /T[:n]  displays only numeric drive Types [of type n,m,..];
ECHO                 n can be:   0 (Unknown),          1 (No Root Directory)
ECHO                             2 (Removable Disk)    3 (Local Disk)
ECHO                             4 (Network Drive)     5 (Compact Disk)
ECHO                             6 (RAM Disk)          or any combination,
ECHO                 e.g. 35 for local disks and CD-ROMs
ECHO.
ECHO NOTE:  If no argument is used, all drives will be listed.
ECHO         Removable drives that are currently unavailable may still be displayed.
ECHO         This batch file uses WMIC, so it won't work in Windows 2000 or XP Home.
ECHO.
exit /B