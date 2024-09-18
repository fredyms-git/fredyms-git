@echo off
title Install Update Chocolatey By Fredy Mardones S :) Soporte Informatica
color 0a
mode con cols=60 lines=29
echoÿออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
echo บ  Implementacion y Configuracion Por Fredy Mardones S.
echo บ         Network Administrator and Support TI			 
echoÿออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
ping localhost -n 3 > nul                                           
echo.
:: .....................................................................
REM .bat con permisos de administrador
:-------------------------------------
REM  --> Analizando los permisos
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> Si hay error es que no hay permisos de administrador.
if '%errorlevel%' NEQ '0' (
    echo Solicitando permisos de administrador... Requesting administrative privileges... Anfordern Administratorrechte ...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
REM   INCLUYE AQU? TU C?DIGO DEL FICHERO .bat
color 0E
mode con cols=80 lines=50
:: .....................................................................
:: .....................................................................
echo ===============================================================================
echo ================ Determinando estado de conexion a internet ===================
echo ===============================================================================
echo.
ping -n 2 www.google.com | find /i "TTL=" > nul && set ICMPREQ=Online1
ping -n 2 8.8.8.8 | find /i "TTL=" > nul && set ICMPREQ=Online1
ping -n 2 208.67.222.222 | find /i "TTL=" > nul && set ICMPREQ=Online1
ping -n 2 9.9.9.9 | find /i "TTL=" > nul && set ICMPREQ=Online1
ping -n 2 1.1.1.1 | find /i "TTL=" > nul && set ICMPREQ=Online1
rem ping -n 2 www.proogle.com | find /i "TTL=" > nul && set ICMPNOREQ=Online1
rem ping -n 2 www.sitioxxblabla.com | find /i "TTL=" > nul && set ICMPNOREQ=Online1
echo.
if "%ICMPREQ%"=="Online1" ( 
	echo Online! & echo. & ping -n 3 1.1.1.1 | find /i "TTL=" & echo. & goto OnlineHost
	) else (
	goto OfflineHost
	)
echo.
rem Si hay respuesta de google, el host est? online!
rem Si no, Offline!
:: .....................................................................
:OnlineHost
:: .....................................................................
echo ===============================================================================
echo =============================== Install Chocolatey ============================
echo ===============================================================================
%ProgramData%
C:\ProgramData\chocolatey
 C:\ProgramData\chocolatey\bin\choco.exe
:: .....................................................................
echo.
rem powershell Set-ExecutionPolicy Unrestricted -Force
rem "powershell.exe" "-Command" "if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy -Scope Process Bypass }; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
rem "powershell.exe" "-Command" "if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 }; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
echo Update Install Agosto2024
echo.
"powershell.exe" "-Command" "if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 }; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
rem echo update Command install Chocolatey Marzo 2020
rem Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
echo.
ping localhost -n 10 > nul
cls
color 0C
mode con cols=80 lines=50
echo ===============================================================================
echo =============================== Update Chocolatey =============================
echo ===============================================================================
:: .....................................................................
rem Command help for Choco
	rem choco install dotnet silverlight
	rem choco upgrade dotnet silverlight
	rem choco uninstall dotnet silverlight
rem Switches
	rem -y (-yes) Suprime interaccion con la instalacion.
	rem -f (-force) Forzar la reinstalacion, no es recomendable si se necesita solo actualizar.
	rem -v (-verbose) Muestra todo el proceso de instalacion.
echo.
echo Install Chocolatey, Extension Chocolatey
ping localhost -n 5 > nul
choco install chocolatey chocolatey-core.extension chocolatey-windowsupdate.extension -y
:: .....................................................................
ping localhost -n 5 > nul
echo.
:: .....................................................................
echo ===============================================================================
echo ================================== Install Soft ===============================
echo ===============================================================================
:: .....................................................................
echo.
echo Install Visual, Dotnet, Powershell 5.1, Microsoft...
ping localhost -n 5 > nul
choco install vcredist-all vcredist2005 vcredist140 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2015 vcredist2017 -y
choco install dotnet directx powershell -y
echo.
rem delete Silverblabla
rem Install Windows Management Framework and PowerShell 5.1.14409.20180811
rem https://chocolatey.org/packages/PowerShell
echo.
rem echo Install vcredist2019...
rem Ya no es necesario, actualizado! 30-11-2022
rem Solucion para instalar VC_redist2019, no lo tiene Chocolatey
rem echo.
rem if %PROCESSOR_ARCHITECTURE% == AMD64 goto ver_x64
rem if %PROCESSOR_ARCHITECTURE% == x86 goto ver_x86
rem :ver_x64
rem "\\dc1\Alumnos\Soft\Windows-Update\VC_redist_all_2015_2019\VC_redist.x64.exe" /install /passive /norestart
rem goto next2
rem :ver_x86
rem "\\dc1\Alumnos\Soft\Windows-Update\VC_redist_all_2015_2019\VC_redist.x86.exe" /install /passive /norestart
rem Microsoft Visual C++ Redistributable latest supported downloads
rem https://learn.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170
echo.
rem :next2
:: .....................................................................
echo Install Others Soft...
ping localhost -n 5 > nul
rem choco install winrar 7zip k-litecodecpackfull vlc xnview paint.net -y
rem choco install notepadplusplus atom -y
rem choco install firefox googlechrome -y
rem Install uBlock Origin for Chrome and Firefox
rem choco install ublockorigin-chrome ublockorigin-firefox -y
rem Install Foxit Reader
rem choco install foxitreader -y
rem Install Adobe Acrobat Reader DC, Disable autoUpdate
rem choco install adobereader -params '"/DesktopIcon /NoUpdates"' -y
echo.
:: .....................................................................
echo Uninstall Flash Player for (Firefox, Chrome, IE)
echo.
echo Flash Player DEPRECATED 31 dic 2020
rem echo Install Flash Player for (Firefox, Chrome, IE)
ping localhost -n 5 > nul
choco uninstall flashplayerplugin flashplayeractivex flashplayerppapi -y
rem Install Disable Update Flashplayerplugin
choco uninstall flashplayerplugin-disable-updates-winconfig -y
echo.
:: .....................................................................
echo Install Java Runtime
ping localhost -n 5 > nul
choco install javaruntime -y
rem echo.
color 0a
:: .....................................................................
echo ===============================================================================
echo ================================== Upgrade All ================================
echo ===============================================================================
:: .....................................................................
echo Upgrade Chocolatey, Extension Chocolatey
echo.
ping localhost -n 5 > nul
choco upgrade chocolatey chocolatey-core.extension chocolatey-windowsupdate.extension -y
echo.
echo Upgrade Visual, Dotnet, Powershell 5.1, Microsoft...
ping localhost -n 5 > nul
choco upgrade vcredist-all vcredist2005 vcredist140 vcredist2008 vcredist2010 vcredist2012 vcredist2013 vcredist2015 vcredist2017 -y
choco upgrade dotnet directx powershell -y
rem choco upgrade dotnet3.5
echo.
rem Delete silverlight, dotnet3.5, 2022
rem Upgrade Windows Management Framework and PowerShell 5.1.14409.20180811
rem https://chocolatey.org/packages/PowerShell
echo.
:: .....................................................................
echo Upgrade Others Soft...
ping localhost -n 5 > nul
rem choco upgrade winrar 7zip k-litecodecpackfull vlc xnview paint.net -y
rem choco upgrade notepadplusplus atom -y
rem choco upgrade firefox googlechrome -y
rem Upgrade uBlock Origin for Chrome and Firefox
rem choco upgrade ublockorigin-chrome ublockorigin-firefox -y
rem choco upgrade foxitreader -y
rem Upgrade Adobe Acrobat Reader DC, Disable autoUpdate
rem choco upgrade adobereader -params '"/DesktopIcon /NoUpdates"'
echo.
:: .....................................................................
echo Flash Player DEPRECATED 31 dic 2020
echo.
echo DEPRECATED Flash Player for (Firefox, Chrome, IE)
ping localhost -n 5 > nul
choco uninstall flashplayerplugin flashplayeractivex flashplayerppapi -y
rem Upgrade disable Update Flashplayerplugin
choco uninstall flashplayerplugin-disable-updates-winconfig -y
echo.
:: .....................................................................
echo Upgrade Java Runtime
ping localhost -n 5 > nul
choco upgrade javaruntime -y
echo.
goto Salir
:: .....................................................................
rem choco upgrade all -y
rem Actualiza todo el software instalado en Windows, independiente si fue instalado con Chocolatey.
echo.
rem https://chocolatey.org/docs/commands-upgrade
rem https://www.online-tech-tips.com/software-reviews/how-to-automatically-update-free-software-with-chocolatey/
echo.
rem choco install javaruntime -force -y
:: .....................................................................
:OfflineHost
echo "Equipo OFFLINE, conecta a internet para continuar"
:salir
echo.
ping localhost -n 5 > nul
echo.
echoÿออออออออออออออออออออออออออออออป
echo บCreado por Fredy Mardones S.
echoÿออออออออออออออออออออออออออออออผ
echo.
ping localhost -n 5 > nul
echoÿอออออออออออออป
echo บSoporte TI
echoÿอออออออออออออผ
ping localhost -n 3 > nul
echo.
echoÿอออออออออออออออออออป
echo บ 2024
echoÿอออออออออออออออออออผ
ping localhost -n 3 > nul
echo.
echoÿอออออออออออออออออออออออออออออออป
echo บfredy.informatico1@gmail.com
echoÿอออออออออออออออออออออออออออออออผ
echo.
echo.
echo.
echo Ya puedes cerrar la ventana, presionando ENTER.
echo.
ping localhost -n 5 > nul 
rem pause > nul
exit
