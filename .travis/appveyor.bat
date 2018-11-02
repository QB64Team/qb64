SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
del /q /s internal\c\libqb\*.o >nul 2>nul
del /q /s internal\c\libqb\*.a >nul 2>nul
del /q /s internal\c\parts\*.o >nul 2>nul
del /q /s internal\c\parts\*.a >nul 2>nul
del /q /s internal\temp\*.* >nul 2>nul

cd internal\c\c_compiler
echo Extracting C++ compiler
7z\7za.exe x -y c_compiler.7z >nul
cd ..\..\..

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
cd ..\..

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
