Open-with

This repository contains Windows batch scripts that add "Open with ..." entries to the Windows Explorer context menu.

Included scripts
- Add_OpenWithCode.bat — Adds an "Open with Code" entry for files and folders (Visual Studio Code).
- Add_OpenWithAntigravity.bat — Adds an "Open with Agy" entry for files and folders (Google Antigravity).

How it works
- Each script attempts to detect the target application's installation path and generates a properly escaped .reg file.
- The .reg file is applied with `regedit /s`, and File Explorer is restarted to apply the changes.
- Scripts try to auto-elevate to administrator privileges when needed.

Usage
1. Run the desired .bat file (the script will request elevation if necessary).
2. The script will apply registry changes and restart Explorer.

Notes
- These scripts are intended for Windows only.
- Review the batch files before running and back up the registry if needed.
- See the scripts in this repository for implementation details and exact behavior.


