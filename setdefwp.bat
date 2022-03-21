@ECHO OFF

IF      "%~1"==""      GOTO Syntax
IF  /i  "%~1"=="--h"   GOTO Syntax
IF  /i  "%~1"=="-help" GOTO Syntax
IF  /i  "%~1"=="/?"    GOTO Syntax
IF NOT "%~2"==""            GOTO Syntax
 

ECHO.%* | FIND "/" > NUL && GOTO Syntax
ECHO.%* | FIND "?" > NUL && GOTO Syntax
ECHO.%* | FIND "*" > NUL && GOTO Syntax
 

PUSHD %windir%
IF NOT EXIST "%~1"          GOTO Syntax
DIR /A-D "%~1" >NUL 2>&1 || GOTO Syntax
SET WallPaper=%~f1
POPD
 

SET WallPaper=%WallPaper:\=\\%
 

>  "%Temp%.\wallpaper.reg" ECHO REGEDIT4
>> "%Temp%.\wallpaper.reg" ECHO.
>> "%Temp%.\wallpaper.reg" ECHO [HKEY_CURRENT_USER\Control Panel\Desktop]
>> "%Temp%.\wallpaper.reg" ECHO "Wallpaper"="%WallPaper%"
>> "%Temp%.\wallpaper.reg" ECHO.
 

START /WAIT REGEDIT.EXE /S "%Temp%.\wallpaper.reg"
 

RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1 True
 

SET WallPaper=
DEL "%Temp%.\wallpaper.reg"
 

GOTO:EOF
 
 
:Syntax
ECHO.
ECHO BatchX %~nx0
ECHO %~nx0 : Set the specified .bmp file to the default Windows' wallpapers
ECHO Usage: 
ECHO    $ %~n0  bitmap
ECHO.
ECHO Where:  "bitmap"  is the bitmap file
ECHO         (or the fully qualified path if not located in %windir%)
ECHO.
exit /b