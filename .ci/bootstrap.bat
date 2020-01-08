@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

cd internal\c
set MINGW=mingw32
IF "%PLATFORM%"=="x64" set MINGW=mingw64
ren %MINGW% c_compiler
cd ../..

echo Building library 'LibQB'
cd internal\c\libqb\os\win
call setup_build.bat
IF ERRORLEVEL 1 exit /b 1

cd ..\..\..\..\..

echo Building library 'FreeType'
cd internal\c\parts\video\font\ttf\os\win
call setup_build.bat
IF ERRORLEVEL 1 exit /b 1

cd ..\..\..\..\..\..\..\..

echo Building library 'Core:FreeGLUT'
cd internal\c\parts\core\os\win
call setup_build.bat
IF ERRORLEVEL 1 exit /b 1

cd ..\..\..\..\..\..

echo Bootstrapping QB64
copy internal\source\*.* internal\temp\ >nul
copy source\qb64.ico internal\temp\ >nul
copy source\icon.rc internal\temp\ >nul
cd internal\c
c_compiler\bin\windres.exe -i ..\temp\icon.rc -o ..\temp\icon.o
c_compiler\bin\g++ -mconsole -s -Wfatal-errors -w -Wall qbx.cpp libqb\os\win\libqb_setup.o ..\temp\icon.o -D DEPENDENCY_LOADFONT  parts\video\font\ttf\os\win\src.o -D DEPENDENCY_SOCKETS -D DEPENDENCY_NO_PRINTER -D DEPENDENCY_ICON -D DEPENDENCY_NO_SCREENIMAGE parts\core\os\win\src.a -lopengl32 -lglu32   -mwindows -static-libgcc -static-libstdc++ -D GLEW_STATIC -D FREEGLUT_STATIC     -lws2_32 -lwinmm -lgdi32 -o "..\..\qb64_bootstrap.exe"
IF ERRORLEVEL 1 exit /b 1

