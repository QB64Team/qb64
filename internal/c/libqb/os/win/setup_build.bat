..\..\..\%MINGW%\bin\g++ -c -w -Wall ^
	"..\..\..\libqb.cpp" ^
	-D DEPENDENCY_SOCKETS -D DEPENDENCY_NO_PRINTER -D DEPENDENCY_ICON ^
	-D DEPENDENCY_NO_SCREENIMAGE -D DEPENDENCY_LOADFONT ^
	-D FREEGLUT_STATIC ^
	-o "libqb_setup.o"
