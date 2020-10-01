@ECHO OFF
SETLOCAL ENABLEEXTENSIONS DISABLEDELAYEDEXPANSION

PUSHD %~dp0
ECHO QB64 Setup
ECHO:

DEL /Q /D "internal\c\libqb\*.o" >NUL 2>NUL
DEL /Q /S "internal\c\libqb\*.a" >NUL 2>NUL
DEL /Q /S "internal\c\parts\*.o" >NUL 2>NUL
DEL /Q /S "internal\c\parts\*.a" >NUL 2>NUL
DEL /Q /S "internal\temp\*.*"    >NUL 2>NUL

IF DEFINED MINGW GOTO arch_set

REG Query "HKLM\Hardware\Description\System\CentralProcessor\0" | FIND /i "x86" > NUL && SET "MINGW=mingw32" || SET "MINGW=mingw64"

:arch_set
ECHO Using %MINGW% as C++ Compiler
ECHO:

ECHO Building library 'LibQB'
PUSHD "internal/c/libqb/os/win"
IF EXIST "libqb_setup.o" DEL "libqb_setup.o"
CALL "setup_build.bat"
POPD

ECHO Building library 'FreeType'
PUSHD "internal/c/parts/video/font/ttf/os/win"
IF EXIST "src.o" DEL "src.o"
CALL "setup_build.bat"
POPD

ECHO Building library 'Core:FreeGLUT'
PUSHD "internal/c/parts/core/os/win"
IF EXIST "src.a" DEL "src.a"
CALL "setup_build.bat"
POPD

ECHO Building 'QB64'
COPY "internal\source\*.*" "internal\temp\" >NUL
COPY "source\qb64.ico"     "internal\temp\" >NUL
COPY "source\icon.rc"      "internal\temp\" >NUL
PUSHD "internal\c"
%MINGW%\bin\windres.exe -i "..\temp\icon.rc" -o "..\temp\icon.o"
%MINGW%\bin\g++ -mconsole -s -Wfatal-errors -w -Wall ^
	"qbx.cpp" ^
	"libqb\os\win\libqb_setup.o" ^
	"..\temp\icon.o" ^
	-D DEPENDENCY_LOADFONT "parts\video\font\ttf\os\win\src.o" ^
	-D DEPENDENCY_SOCKETS -D DEPENDENCY_NO_PRINTER -D DEPENDENCY_ICON ^
	-D DEPENDENCY_NO_SCREENIMAGE "parts\core\os\win\src.a" ^
	-lopengl32 -lglu32 -mwindows -static-libgcc -static-libstdc++ ^
	-D GLEW_STATIC -D FREEGLUT_STATIC ^
	-lws2_32 -lwinmm -lgdi32 ^
	-o "..\..\qb64.exe"
POPD

ECHO:
ECHO Launching 'QB64'
qb64

POPD
ECHO:
PAUSE