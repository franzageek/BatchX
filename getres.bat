@ECHO OFF

IF NOT [%1]==[] GOTO Syntax
 
 

SETLOCAL
 

SET VideoCard=
SET XResolution=
SET YResolution=
SET BitsPerPel=
SET VRefresh=
 

REGEDIT /E %Temp%.\Screen.reg "HKEY_CURRENT_CONFIG\System\CurrentControlSet\Services"
 

FOR /F "tokens=* delims=" %%A IN ('TYPE %Temp%.\Screen.reg ^| FIND /V "REGEDIT4" ^| FIND /V ""') DO CALL :Parse01 %%A
 

ECHO.
SET VideoCard
SET XResolution
SET YResolution
SET BitsPerPel
SET VRefresh
 

ENDLOCAL
GOTO :EOF
 
 
:Parse01

IF NOT "%VideoCard%"=="" IF NOT "%VideoCard%"=="%NewCard%" IF /I NOT "%VideoCard%"=="VgaSave" GOTO:EOF

SET Line=%*

SET Line=%Line:"=%

SET Line=%Line: =%

IF "%Line:~0,6%"=="[HKEY_" FOR /F "tokens=5 delims=\]" %%A IN ('ECHO.%Line%') DO IF NOT "%%A"=="" SET NewCard=%%A

IF NOT "%VideoCard%"=="" IF NOT "%VideoCard%"=="%NewCard%" IF /I NOT "%VideoCard%"=="VgaSave" GOTO:EOF

SET VideoCard=%NewCard%

FOR /F "tokens=1* delims==" %%A IN ('ECHO.%Line%') DO CALL :Parse02 %%A %%B

GOTO :EOF
 
 
:Parse02
 
IF "%2"=="" GOTO :EOF
 
SET InKey=%1
 
SET InValue=%2
 
FOR /F "tokens=2 delims=." %%a IN ('ECHO.%InKey%') DO SET Key=%%a
 
IF /I NOT "%Key%"=="BitsPerPel" IF /I NOT "%Key%"=="XResolution" IF /I NOT "%Key%"=="YResolution" IF /I NOT "%Key%"=="VRefresh" GOTO:EOF
 
FOR /F "tokens=1,2 delims=:" %%a IN ('ECHO.%InValue%') DO (
	SET dWord=%%a
	SET xValue=%%b
)
 
IF /I "%dWord%"=="dword" (SET /A Value = 0X%xValue%) ELSE (SET Value=%dWord%)
 
SET %Key%=%Value%
 
GOTO:EOF
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Read and display the resolution settings from the registry.
ECHO Usage: 
ECHO    $ %~nx0
ECHO.
exit /b