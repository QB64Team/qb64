..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\adler32.c -o temp\adler32.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\compress.c -o temp\compress.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\crc32.c -o temp\crc32.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\deflate.c -o temp\deflate.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\gzclose.c -o temp\gzclose.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\gzlib.c -o temp\gzlib.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\gzread.c -o temp\gzread.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\gzwrite.c -o temp\gzwrite.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\infback.c -o temp\infback.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\inffast.c -o temp\inffast.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\inflate.c -o temp\inflate.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\inftrees.c -o temp\inftrees.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\trees.c -o temp\trees.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\uncompr.c -o temp\uncompr.o
..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\download\zutil.c -o temp\zutil.o

..\..\..\..\c_compiler\bin\ar rcs src.a temp\adler32.o temp\compress.o temp\crc32.o temp\deflate.o  temp\gzclose.o temp\gzlib.o temp\gzread.o temp\gzwrite.o temp\infback.o temp\inffast.o temp\inflate.o  temp\inftrees.o temp\uncompr.o temp\zutil.o

pause


