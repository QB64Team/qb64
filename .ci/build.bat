@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

ECHO Compiling new QB64
ECHO From git %APPVEYOR_REPO_COMMIT:~0,7% > "internal\version.txt"

SETLOCAL DISABLEDELAYEDEXPANSION

SET "MINGW=mingw32"
IF /I "%PLATFORM%" == "x64" SET "MINGW=mingw64"

qb64_bootstrap.exe -z "source\qb64.bas"

CD "internal\c"

%MINGW%\bin\g++ -mconsole -s -Wfatal-errors -w -Wall ^
	"qbx.cpp" ^
	"libqb\os\win\libqb_setup.o" "..\temp\icon.o" ^
	-D DEPENDENCY_LOADFONT "parts\video\font\ttf\os\win\src.o" ^
	-D DEPENDENCY_SOCKETS -D DEPENDENCY_NO_PRINTER -D DEPENDENCY_ICON ^
	-D DEPENDENCY_NO_SCREENIMAGE "parts\core\os\win\src.a" ^
	-lopengl32 -lglu32 -mwindows -static-libgcc -static-libstdc++ ^
	-D GLEW_STATIC -D FREEGLUT_STATIC ^
	-lws2_32 -lwinmm -lgdi32 ^
	-o "..\..\qb64.exe"

IF ERRORLEVEL 1 EXIT /B 1

CD "..\.."

DEL "qb64_bootstrap.exe"
DEL /Q /S "secure-file"
DEL /Q /S "internal\source\*"
MOVE "internal\temp\*" "internal\source\"
DEL /Q /S "internal\c\libqb\*.o" >NUL 2>NUL
DEL /Q /S "internal\c\libqb\*.a" >NUL 2>NUL
DEL /Q /S "internal\c\parts\*.o" >NUL 2>NUL
DEL /Q /S "internal\c\parts\*.a" >NUL 2>NUL
CD "internal\source"
DEL /Q /S "debug_*" "recompile_*"
