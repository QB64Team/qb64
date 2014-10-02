..\..\..\..\c_compiler\bin\gcc -DFREEGLUT_STATIC -I..\..\..\..\ -I..\..\include -c ..\..\src\luke_mods.cpp -o temp\luke_mods.o
..\..\..\..\c_compiler\bin\gcc -DFREEGLUT_STATIC -I..\..\..\..\ -I..\..\include -c ..\..\src\steve_mods.cpp -o temp\steve_mods.o
..\..\..\..\c_compiler\bin\ar rcs src.a temp\steve_mods.o temp\luke_mods.o
pause
