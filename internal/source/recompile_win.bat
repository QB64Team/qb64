@echo off
cd %0\..\
echo Recompiling...
cd ../c
c_compiler\bin\g++ -mconsole -s -Wfatal-errors -w -Wall qbx.cpp  libqb\os\win\libqb_0_990_100000.o  -D DEPENDENCY_LOADFONT  parts\video\font\ttf\os\win\src.o -lws2_32 -lwinspool parts\core\os\win\src.a -lopengl32 -lglu32 -lwinmm -lgdi32 -mwindows -static-libgcc -static-libstdc++ -D GLEW_STATIC -D FREEGLUT_STATIC -lksguid -lole32 -lwinmm -ldxguid -o "..\..\qb64(2).exe"
pause
