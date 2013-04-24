..\..\..\..\..\c_compiler\bin\gcc -c ..\..\src\samplerate.c -o temp\samplerate.o
..\..\..\..\..\c_compiler\bin\gcc -c ..\..\src\src_linear.c -o temp\src_linear.o
..\..\..\..\..\c_compiler\bin\gcc -c ..\..\src\src_sinc.c -o temp\src_sinc.o
..\..\..\..\..\c_compiler\bin\gcc -c ..\..\src\src_zoh.c -o temp\src_zoh.o
..\..\..\..\..\c_compiler\bin\ar rcs src.a temp\samplerate.o temp\src_linear.o temp\src_sinc.o temp\src_zoh.o
pause
