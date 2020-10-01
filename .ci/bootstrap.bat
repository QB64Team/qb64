@ECHO OFF
SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

SET "MINGW=mingw32"
IF /I "%PLATFORM%" == "x64" SET "MINGW=mingw64"

ECHO Building library 'LibQB'
PUSHD "internal\c\libqb\os\win"
CALL "setup_build.bat"
IF ERRORLEVEL 1 POPD & EXIT /B 1
POPD

ECHO Building library 'FreeType'
PUSHD "internal\c\parts\video\font\ttf\os\win"
CALL "setup_build.bat"
IF ERRORLEVEL 1 POPD & EXIT /B 1
POPD

ECHO Building library 'Core:FreeGLUT'
PUSHD "internal\c\parts\core\os\win"
CALL "setup_build.bat"
IF ERRORLEVEL 1 POPD & EXIT /B 1
POPD

ECHO Bootstrapping QB64
COPY "internal\source\*.*" "internal\temp\" >NUL
COPY "source\qb64.ico"     "internal\temp\" >NUL
COPY "source\icon.rc"      "internal\temp\" >NUL

CD "internal\c"
%MINGW%\bin\windres.exe -i "..\temp\icon.rc" -o "..\temp\icon.o"
%MINGW%\bin\g++ -mconsole -s -Wfatal-errors -w -Wall ^
	"qbx.cpp" ^
	"libqb\os\win\libqb_setup.o" ^
	"..\temp\icon.o" ^
	-D DEPENDENCY_LOADFONT "parts\video\font\ttf\os\win\src.o" ^
	-D DEPENDENCY_SOCKETS -D DEPENDENCY_NO_PRINTER -D DEPENDENCY_ICON ^
	-D DEPENDENCY_NO_SCREENIMAGE "parts\core\os\win\src.a" ^
	-lopengl32 -lglu32 -mwindows -static-libgcc -static-libstdc++ ^
	-D GLEW_STATIC -D FREEGLUT_STATIC -lws2_32 -lwinmm -lgdi32 ^
	-o "..\..\qb64_bootstrap.exe"

IF ERRORLEVEL 1 EXIT /B 1

