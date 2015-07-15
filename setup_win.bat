@echo off
echo QB64 Setup
echo.

del /q /s internal\c\libqb\*.o >nul 2>nul
del /q /s internal\c\libqb\*.a >nul 2>nul
del /q /s internal\c\parts\*.o >nul 2>nul
del /q /s internal\c\parts\*.a >nul 2>nul
del /q /s internal\temp\*.* >nul 2>nul

cd internal/c/c_compiler
if exist bin\c++.exe goto skipccompextract
echo Extracting C++ compiler
7z\7za.exe x -y c_compiler.7z >nul
:skipccompextract
cd ../../..

echo Building library 'LibQB'
cd internal/c/libqb/os/win
if exist libqb_setup.o del libqb_setup.o
call setup_build.bat
cd ../../../../..

echo Building library 'FreeType'
cd internal/c/parts/video/font/ttf/os/win
if exist src.o del src.o
call setup_build.bat
cd ../../../../../../../..

echo Building User Additions
cd internal/c/parts/user_mods/os/win
if exist src.a del src.a
call setup_build.bat
cd ../../../../../..

echo Building library 'Core:FreeGLUT'
cd internal/c/parts/core/os/win
if exist src.a del src.a
call setup_build.bat
cd ../../../../../..

cd internal\c\parts\user_mods\os\win
..\..\..\..\c_compiler\bin\gcc -DFREEGLUT_STATIC -I..\..\..\..\ -I..\..\include -c ..\..\src\luke_mods.cpp -o temp\luke_mods.o
..\..\..\..\c_compiler\bin\gcc -DFREEGLUT_STATIC -I..\..\..\..\ -I..\..\include -c ..\..\src\steve_mods.cpp -o temp\steve_mods.o
..\..\..\..\c_compiler\bin\ar rcs src.a temp\steve_mods.o temp\luke_mods.o
cd ..\..\..\..\..\..

echo Building 'QB64'
copy internal\source\*.* internal\temp\ >nul
cd internal\c
c_compiler\bin\g++ -mconsole -s -Wfatal-errors -w -Wall qbx.cpp libqb\os\win\libqb_setup.o parts\user_mods\os\win\src.a -D DEPENDENCY_USER_MODS -D DEPENDENCY_LOADFONT parts\video\font\ttf\os\win\src.o -lws2_32 -lwinspool parts\core\os\win\src.a -lopengl32 -lglu32 -lwinmm -lgdi32 -Wl,--subsystem,windows -static-libgcc -static-libstdc++ -D FREEGLUT_STATIC -lksguid -lole32 -lwinmm -ldxguid -o "..\..\qb64.exe"
cd ..\..

echo.
echo Launching 'QB64'
qb64

echo.
pause
