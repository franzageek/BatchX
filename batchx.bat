@echo off
cd "%~dp0"

net session >nul 2>&1
if %errorlevel%==0 (
	goto :BEGINNING
) else (
	echo BatchX requires to be started in a CMD with Admin Rights.
	exit /b
) 







:BEGINNING
if not exist installedplugins.txt echo.>>installedplugins.txt
if "%~1" == "-inst" goto :install_new_plugins
if "%~1" == "-del" goto :del_plugins
if "%~1" == "-upd" goto :upds
if "%~1" == "-plg" goto :plg
if "%~1" == "--p" goto :plg
if "%~1" == "-help" goto :Syntax
if "%~1" == "--i" goto :install_new_plugins
if "%~1" == "--d" goto :del_plugins
if "%~1" == "--u" goto :upds
if "%~1" == "--h" goto :Syntax
if "%~1" == "/?" goto :Syntax



:Syntax
echo This is the BatchX 0.12 Shell. From here you can add the BatchX Plugins you want
echo by typing their names.
echo Here are some useful commands:
echo.
echo   -inst ^<name^>, --i        Install the plugin called "name". That plugin will
echo                              be downloaded from the repo and moved to the %windir%
echo                              directory.
echo   -del  ^<name^>, --d        Delete the plugin called "name" from your PC.
echo   -upd, --u                  Check for updates.
echo   -plg, --p                  Display the already installed plugins.
echo   -help, --h, /?             Show this help.
echo.
exit /b



:plg
echo These are the BatchX plugins already installed on your PC:
echo.
type installedplugins.txt
exit /b

:install_new_plugins
set plugin=%~2
>nul find "%plugin%" installedplugins.txt && (
  goto :scan1
) || (
  goto :scan2
)


	:scan1
	if exist %plugin%.bat echo "%plugin%" is already installed on your PC. & exit /b
	if not exist %plugin%.bat (
		>nul findstr /V "%plugin%" installedplugins.txt >installedplugins2.txt
		del installedplugins.txt > NUL
		rename installedplugins2.txt installedplugins.txt > NUL
		goto :check
	)
		
	
	:scan2
	if not exist %plugin%.bat goto :check
	if exist %plugin%.bat (
		echo %plugin%>>installedplugins.txt
		echo "%plugin%" is already installed on your PC.
		exit /b
	)
	
	
	

	:check
	if /i %plugin%==ascii2unicode set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/ascii2unicode.bat &goto :download
	if /i %plugin%==bin2dec set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/bin2dec.bat &goto :download
	if /i %plugin%==bootstate set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/bootstate.bat &goto :download
	if /i %plugin%==cdromdrives set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/cdromdrives.bat &goto :download
	if /i %plugin%==dec2bin set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/dec2bin.bat &goto :download
	if /i %plugin%==dec2hex set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/dec2hex.bat &goto :download
	if /i %plugin%==defprinter set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/defprinter.bat &goto :download
	if /i %plugin%==drives set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/drives.bat &goto :download
	if /i %plugin%==enablecad set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/enablecad.bat &goto :download	
	if /i %plugin%==findunins set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/findunins.bat &goto :download
	if /i %plugin%==getres set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/getres.bat &goto :download
	if /i %plugin%==lastfile set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/lastfile.bat &goto :download
	if /i %plugin%==num2bin set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/num2bin.bat &goto :download
	if /i %plugin%==num2hex set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/num2hex.bat &goto :download
	if /i %plugin%==num2oct set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/num2oct.bat &goto :download
	if /i %plugin%==reverse set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/reverse.bat &goto :download
	if /i %plugin%==setdefwp set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/setdefwp.bat &goto :download
	if /i %plugin%==viewowner set dllink=https://raw.githubusercontent.com/franzageek/BatchX/master/viewowner.bat &goto :download
	echo Cannot find any plugin named "%plugin%".
	exit /b 

		:download
		echo Ready to download %plugin%.
		echo %dllink% >link.txt
		call downloader.bat
		exit /b



:del_plugins
set plugintodel=%~2
>nul find "%plugintodel%" installedplugins.txt && (
  goto :check1
) || (
  goto :check2
)
	:check1
	if exist %plugintodel%.bat goto :del
	if not exist %plugintodel%.bat (
		echo Cannot find any installed plugin named "%plugintodel%".
		>nul findstr /V "%plugintodel%" installedplugins.txt >installedplugins2.txt
		del installedplugins.txt 
		rename installedplugins2.txt installedplugins.txt
		exit /b
	)
	
	:check2
	if not exist %plugintodel%.bat echo Cannot find any installed plugin named "%plugintodel%". & exit /b
	if exist %plugintodel%.bat echo %plugintodel%>>installedplugins.txt goto :del
		
		:del
		choice /c YN /m "Are you sure you want to delete %plugintodel%"
		if %errorlevel%==1 (
			del	%plugintodel%.bat > nul
			if exist %plugintodel%.bat del %plugintodel%.bat > nul
			>nul findstr /V "%plugintodel%" installedplugins.txt > installedplugins2.txt
			echo Plugin deleted successfully.
			del installedplugins.txt
			ren installedplugins2.txt installedplugins.txt
			exit /b
		)
		if %errorlevel%==2 (
			echo Operation canceled.
			exit /b
		)
		


:upds
echo Here you can update BatchX Shell whenever you want.
echo You can try to download the latest version, if it exist.
echo So, when you want to update your BatchX Shell, simply 
echo type "batchx --u".
echo.
choice /c YN /m "Would you like to download the latest version of the shell now"
if %errorlevel%==1 (
	goto :updnow
)
if %errorlevel%==2 (
	echo Operation canceled.
	exit /b
)


	:updnow
	cls
	echo Downloading the latest version... []
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [=]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [==]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [===]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [====]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [=====]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [======]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [=======]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [========]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [=========]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [==========]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [===========]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [============]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [=============]
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [=============^>]
	wget https://raw.githubusercontent.com/franzageek/BatchX/latest/batchxshell.bat 2> nul
	wget https://raw.githubusercontent.com/franzageek/BatchX/updfiles/applyupd.bat 2> nul
      if exist .wget-hsts del .wget-hsts
	title %windir%\system32\cmd.exe
	ping 127.0.0.1 -n 1 -w 500000000 > nul
	cls
	echo Downloading the latest version... [=============^>] 
	echo Download complete. Please wait...
	timeout /t 2 /nobreak > nul 
	cls
	echo Installing...	
	call applyupd.bat
	exit /b


