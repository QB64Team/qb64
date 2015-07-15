#!/bin/sh
gcc -c ../../src/minimp3.c -o temp/minimp3.o
ar rcs src.a temp/minimp3.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

