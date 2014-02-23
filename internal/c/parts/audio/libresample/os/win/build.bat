..\..\..\..\..\c_compiler\bin\gcc -c ..\..\src\filterkit.c -o temp\filterkit.o
..\..\..\..\..\c_compiler\bin\gcc -c ..\..\src\resample.c -o temp\resample.o
..\..\..\..\..\c_compiler\bin\gcc -c ..\..\src\resamplesubs.c -o temp\resamplesubs.o
..\..\..\..\..\c_compiler\bin\ar rcs src.a temp\filterkit.o temp\resample.o temp\resamplesubs.o
pause
