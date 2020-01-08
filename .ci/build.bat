SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

echo Compiling new QB64
echo From git %APPVEYOR_REPO_COMMIT:~0,7% > internal\version.txt
qb64_bootstrap.exe -x source\qb64.bas -o qb64.exe
IF ERRORLEVEL 1 exit /b 1

del qb64_bootstrap.exe
del /q /s secure-file
del /q /s internal\source\*
move internal\temp\* internal\source\
del /q /s internal\c\libqb\*.o >nul 2>nul
del /q /s internal\c\libqb\*.a >nul 2>nul
del /q /s internal\c\parts\*.o >nul 2>nul
del /q /s internal\c\parts\*.a >nul 2>nul
cd internal\source
del /q /s debug_* recompile_*
