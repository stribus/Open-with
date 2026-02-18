@echo off
:: Batch script to add "Open with Agy" to context menu (proper escaping)
:: Automatically elevates to Admin if needed

:: Check for admin rights
fltmc >nul 2>&1 || (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~0'"
    exit /b
)

:: Detect VS Code path (checks both default locations)
set "agy_path="
for %%d in (
    "%ProgramFiles%\Antigravity\Antigravity.exe"
    "%APPDATA%\Antigravity\Antigravity.exe"
    "%LOCALAPPDATA%\Programs\Antigravity\Antigravity.exe"
) do if exist "%%~d" set "agy_path=%%~d"

if not defined agy_path (
    echo Error: Antigravity not found in:
    echo - "%ProgramFiles%\Antigravity\Antigravity.exe"
    echo - "%APPDATA%\Antigravity\Antigravity.exe"
    echo - "%LocalAppData%\Programs\Antigravity\Antigravity.exe"
    pause
    exit /b 1
)

echo Found Antigravity at: %agy_path%

:: Generate .reg file with CORRECT escaping (like your original)
(
    echo Windows Registry Editor Version 5.00
    echo;
    echo [-HKEY_CLASSES_ROOT\Directory\shell\OpenWithAntigravity]
    echo [-HKEY_CLASSES_ROOT\*\shell\OpenWithAntigravity]
    echo;
    echo [HKEY_CLASSES_ROOT\Directory\shell\OpenWithAntigravity]
    echo @="Open with Agy"
    echo "Icon"="\"%agy_path:\=\\%\",0"
    echo;
    echo [HKEY_CLASSES_ROOT\Directory\shell\OpenWithAntigravity\command]
    echo @="\"%agy_path:\=\\%\" \"%%1\""
    echo;
    echo [HKEY_CLASSES_ROOT\*\shell\OpenWithAntigravity]
    echo @="Open with Agy"
    echo "Icon"="\"%agy_path:\=\\%\",0"
    echo;
    echo [HKEY_CLASSES_ROOT\*\shell\OpenWithAntigravity\command]
    echo @="\"%agy_path:\=\\%\" \"%%1\""
) > "%temp%\OpenWithAntigravity.reg"

:: Apply changes silently
regedit /s "%temp%\OpenWithAntigravity.reg"

:: Restart File Explorer to apply changes
taskkill /f /im explorer.exe >nul
start explorer.exe

echo Success! "Open with Agy" added to context menu.
pause