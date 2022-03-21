@ECHO OFF

IF     "%~1"=="" GOTO Syntax
IF NOT "%~3"=="" GOTO Syntax
ECHO "%~1" | FINDSTR /R /C:"[/?]" >NUL && GOTO Syntax
SET Computer=
IF NOT "%~2"=="" (
	PING -a -n 1 "%~2" | FIND /I "%~2" >NUL
	IF ERRORLEVEL 1 (
		ECHO.
		ECHO ERROR: Could not find remote computer "%~2"
		GOTO Syntax
	)
)
 
SETLOCAL ENABLEDELAYEDEXPANSION
IF "%~2"=="" (
	SET Computer=
	SET Node=
) ELSE (
	FOR /F "delims=[" %%A IN ('PING -a -n 1 "%~2" ^| FIND "[" ^| FIND /I "%~2"') DO SET Computer=%%A
	FOR %%A IN (!Computer!) DO SET Computer=%%A
	SET Computer=\\!Computer!\
	SET Node=/Node:"!Computer:~2,-1!"
)
 
SET Count=0
FOR /F "tokens=*" %%A IN ('REG Query %Computer%HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /F "%~1" /D /S 2^>NUL ^| FINDSTR /R /C:"HKEY_"') DO (
	SET Found=0
	(REG Query "%Computer%%%~A" /F DisplayName /V /E | FINDSTR /R /I /C:" DisplayName .* .*%Filter%" && SET Found=1) >NUL 2>&1
	(REG Query "%Computer%%%~A" /F Publisher   /V /E | FINDSTR /R /I /C:" Publisher .* .*%Filter%"   && SET Found=1) >NUL 2>&1
	IF !Found! EQU 1 (
		SET /A Count += 1
		FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F DisplayName    /V /E 2^>NUL ^| FIND /I " DisplayName "')     DO ECHO Program Name      = %%C
		FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F DisplayVersion /V /E 2^>NUL ^| FIND /I " DisplayVersion "')  DO ECHO Program Version   = %%C
		FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F Publisher      /V /E 2^>NUL ^| FIND /I " Publisher "')       DO ECHO Publisher         = %%C
		FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F InstallDate    /V /E 2^>NUL ^| FIND /I " InstallDate "')     DO (
			SET InstallDate=%%C
			ECHO Install Date      = !InstallDate:~0,4!-!InstallDate:~4,2!-!InstallDate:~6!
		)
		FOR /F "tokens=7 delims=\" %%B IN ("%%~A") DO ECHO Unique Identifier = %%B
		FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F UninstallString /V /E ^| FIND /I " UninstallString "') DO ECHO Uninstall String  = %%C
		ECHO.
	)
)
 
WMIC.EXE %Node% Path Win32_Processor Get DataWidth 2>NUL | FIND "64" >NUL
IF ERRORLEVEL 1 (
	ECHO.
	ECHO %Count% programs found
) ELSE (
	SET Count32bit=0
	FOR /F "tokens=*" %%A IN ('REG Query %Computer%HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall /F "%~1" /D /S 2^>NUL ^| FINDSTR /R /C:"HKEY_"') DO (
		SET Found=0
		(REG Query "%Computer%%%~A" /F DisplayName /V /E | FINDSTR /R /I /C:" DisplayName .* .*%Filter%" && SET Found=1) >NUL 2>&1
		(REG Query "%Computer%%%~A" /F Publisher   /V /E | FINDSTR /R /I /C:" Publisher .* .*%Filter%"   && SET Found=1) >NUL 2>&1
		IF !Found! EQU 1 (
			SET /A Count32bit += 1
			FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F DisplayName    /V /E 2^>NUL ^| FIND /I " DisplayName "')     DO ECHO Program Name      = %%C
			FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F DisplayVersion /V /E 2^>NUL ^| FIND /I " DisplayVersion "')  DO ECHO Program Version   = %%C
			FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F Publisher      /V /E 2^>NUL ^| FIND /I " Publisher "')       DO ECHO Publisher         = %%C
			FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F InstallDate    /V /E 2^>NUL ^| FIND /I " InstallDate "')     DO (
				SET InstallDate=%%C
				ECHO Install Date      = !InstallDate:~0,4!-!InstallDate:~4,2!-!InstallDate:~6!
			)
			FOR /F "tokens=7 delims=\" %%B IN ("%%~A") DO ECHO Unique Identifier = %%B
			FOR /F "tokens=2*" %%B IN ('REG Query "%Computer%%%~A" /F UninstallString /V /E ^| FIND /I " UninstallString "') DO ECHO Uninstall String  = %%C
			ECHO.
		)
	)
	ECHO.
	ECHO     %Count% 64-bit programs and !Count32bit! 32-bit programs found
)
 
ENDLOCAL
GOTO:EOF
 
 
:Syntax
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : List the uninstall command/program to the specified program.
ECHO Usage: 
ECHO    $ %~nx0 "program"  [ computer ]
ECHO.
ECHO Where:    "program"   narrows down the search result to programs whose
ECHO                       uninstall data contains the string "program" (in quotes)
ECHO           "computer"  is an optional remote computer to be searched
ECHO                       (host name or IP adress)
ECHO.
ECHO Example: 
ECHO    $ %~nx0 "Google Chrome"
ECHO.
exit /b
 
