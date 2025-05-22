@echo off
title WSL Installation and Management Tool
color 0a
setlocal EnableDelayedExpansion

:: Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please run this script as an administrator.
    pause
    exit /b
)

:MENU
cls
echo =============================================== 
echo "   ___  _  _   __    __   __ _  __ _  _  _  "
echo "  / __)/ )( \ /  \  /  \ (  ( \(  / )( \/ ) "
echo " ( (__ ) __ ((  O )(  O )/    / )  (  )  /  "
echo "  \___)\_)(_/ \__/  \__/ \_)__)(__\_)(__/   "
echo "           WSL MANAGEMENT TOOL              "
echo =============================================== 
echo        1. Check System Compatibility
echo        2. Check WSL Installation Status
echo        3. Install WSL Components
echo        4. Manage WSL Storage
echo        5. Show Available Linux Distributions
echo        6. Install Linux Distribution
echo        7. Uninstall Linux Distribution
echo        8. Backup a Linux Distribution
echo        9. Restore a Linux Distribution
echo        10. Exit
echo ===============================================
set /p choice=Enter your choice (1-10): 

if "%choice%"=="1" goto CHECK_COMPATIBILITY
if "%choice%"=="2" goto CHECK_WSL_STATUS
if "%choice%"=="3" goto INSTALL_WSL
if "%choice%"=="4" goto MANAGE_STORAGE
if "%choice%"=="5" goto SHOW_DISTROS
if "%choice%"=="6" goto INSTALL_DISTRO
if "%choice%"=="7" goto UNINSTALL_DISTRO
if "%choice%"=="8" goto BACKUP_DISTRO
if "%choice%"=="9" goto IMPORT_DISTRO
if "%choice%"=="10" exit
goto MENU

:CHECK_COMPATIBILITY
cls
echo Checking system compatibility...
systeminfo | findstr /i "OS Name OS Version System Type Hyper-V" || echo Failed to retrieve system info.
pause
goto MENU

:CHECK_WSL_STATUS
cls
echo Checking WSL installation status...
wsl --status || echo WSL is not installed or not available on this system.
pause
goto MENU

:INSTALL_WSL
cls
echo Installing WSL components...
wsl --install || echo Failed to install WSL. Make sure your Windows version supports it.
pause
goto MENU

:MANAGE_STORAGE
cls
echo Managing WSL storage...
wsl --shutdown
echo Shutdown all running WSL instances.
pause
goto MENU

:SHOW_DISTROS
cls
echo Available Linux Distributions:
wsl --list --online || echo Failed to list distributions.
pause
goto MENU

:INSTALL_DISTRO
cls
echo Enter the name of the Linux distribution to install (e.g., Ubuntu):
set /p distroName=Distribution Name: 
if "%distroName%"=="" (
    echo Invalid input. Please try again.
    pause
    goto MENU
)
wsl --install -d %distroName% || echo Failed to install %distroName%.
pause
goto MENU

:UNINSTALL_DISTRO
cls
echo Installed Distributions:
wsl --list --verbose
echo Enter the name of the Linux distribution to uninstall:
set /p uninstallName=Distribution Name: 
if "%uninstallName%"=="" (
    echo Invalid input. Please try again.
    pause
    goto MENU
)
wsl --unregister %uninstallName% || echo Failed to uninstall %uninstallName%.
pause
goto MENU

:BACKUP_DISTRO
cls
echo Enter the distribution name to export:
set /p distroToExport=Distribution Name: 
echo Enter the full path to save the backup (e.g., C:\WSLBackup\backup.tar):
set /p exportPath=Backup Path: 
if "%distroToExport%"=="" (
    echo Invalid input. Please try again.
    pause
    goto MENU
)
wsl --export %distroToExport% "%exportPath%" || echo Export failed.
pause
goto MENU

:IMPORT_DISTRO
cls
echo Enter a name for the new WSL instance:
set /p newName=New Distro Name: 
echo Enter the path to the backup TAR file:
set /p importPath=Backup File Path: 
echo Enter install location (e.g., C:\WSL\MyDistro):
set /p targetPath=Install Location: 
if "%newName%"=="" (
    echo Invalid input. Please try again.
    pause
    goto MENU
)
wsl --import %newName% "%targetPath%" "%importPath%" || echo Import failed.
pause
goto MENU
