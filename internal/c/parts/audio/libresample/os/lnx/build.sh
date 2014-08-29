#!/bin/sh
gcc -c ../../src/filterkit.c -o temp/filterkit.o
gcc -c ../../src/resample.c -o temp/resample.o
gcc -c ../../src/resamplesubs.c -o temp/resamplesubs.o
ar rcs src.a temp/filterkit.o temp/resample.o temp/resamplesubs.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

