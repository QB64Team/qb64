..\..\..\..\..\..\c_compiler\bin\g++ -c ..\..\src\common.c -o temp\common.o
..\..\..\..\..\..\c_compiler\bin\g++ -c ..\..\src\dct64_i386.c -o temp\dct64_i386.o
..\..\..\..\..\..\c_compiler\bin\g++ -c ..\..\src\decode_i386.c -o temp\decode_i386.o
..\..\..\..\..\..\c_compiler\bin\g++ -c ..\..\src\interface.c -o temp\interface.o
..\..\..\..\..\..\c_compiler\bin\g++ -c ..\..\src\layer2.c -o temp\layer2.o
..\..\..\..\..\..\c_compiler\bin\g++ -c ..\..\src\layer3.c -o temp\layer3.o
..\..\..\..\..\..\c_compiler\bin\g++ -c ..\..\src\tabinit.c -o temp\tabinit.o
..\..\..\..\..\..\c_compiler\bin\ar rcs src.a temp\common.o temp\dct64_i386.o temp\decode_i386.o temp\interface.o temp\layer2.o temp\layer3.o temp\tabinit.o
pause
