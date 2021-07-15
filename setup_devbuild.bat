@echo off
setlocal
echo QB64 Working Tree Setup
echo.

del /q /s qb64dev.exe >nul 2>nul
del /q /s internal\temp\*.* >nul 2>nul

if exist internal\c\c_compiler\bin\c++.exe goto skipccompsetup
cd internal\c
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set MINGW=mingw32 || set MINGW=mingw64
echo Using %MINGW% as C++ Compiler
ren %MINGW% c_compiler
cd ../..
:skipccompsetup

echo Building 'QB64', dev build...
qb64 -z source\qb64.bas
copy source\qb64.ico internal\temp\ >nul
copy source\icon.rc internal\temp\ >nul
cd internal\c
c_compiler\bin\windres.exe -i ..\temp\icon.rc -o ..\temp\icon.o
c_compiler\bin\g++ -mconsole -s -Wfatal-errors -w -Wall qbx.cpp libqb\os\win\libqb_setup.o ..\temp\icon.o -D DEPENDENCY_LOADFONT  parts\video\font\ttf\os\win\src.o -D DEPENDENCY_SOCKETS -D DEPENDENCY_NO_PRINTER -D DEPENDENCY_ICON -D DEPENDENCY_NO_SCREENIMAGE parts\core\os\win\src.a -lopengl32 -lglu32   -mwindows -static-libgcc -static-libstdc++ -D GLEW_STATIC -D FREEGLUT_STATIC     -lws2_32 -lwinmm -lgdi32 -o "..\..\qb64dev.exe"
cd ..\..
if exist qb64dev.exe goto success

color 4F
echo Compilation failed.
goto pauseit

:success
color 2F
echo.
echo Launching 'QB64', dev build...
qb64dev
goto done

:pauseit
echo.
pause

:done