@echo off
setlocal
title Install AutoUploadLongMessages for Vencord

set "INSTALLER=%TEMP%\AutoUploadLongMessages-Install.ps1"
set "INSTALLER_URL=https://github.com/eric99543/vencord-auto-upload-long-messages/releases/latest/download/Install.ps1"

echo Downloading the latest AutoUploadLongMessages installer...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -UseBasicParsing -Uri '%INSTALLER_URL%' -OutFile '%INSTALLER%'"
if errorlevel 1 goto :failed

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%INSTALLER%" %*
if errorlevel 1 goto :failed

del /q "%INSTALLER%" >nul 2>&1
echo.
echo Installation completed successfully.
pause
exit /b 0

:failed
echo.
echo Installation failed. Review the message above for details.
pause
exit /b 1
