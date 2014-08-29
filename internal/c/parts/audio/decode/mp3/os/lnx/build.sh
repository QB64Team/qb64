#!/bin/sh
g++ -c ../../src/common.c -o temp/common.o
g++ -c ../../src/dct64_i386.c -o temp/dct64_i386.o
g++ -c ../../src/decode_i386.c -o temp/decode_i386.o
g++ -c ../../src/interface.c -o temp/interface.o
g++ -c ../../src/layer2.c -o temp/layer2.o
g++ -c ../../src/layer3.c -o temp/layer3.o
g++ -c ../../src/tabinit.c -o temp/tabinit.o
ar rcs src.a temp/common.o temp/dct64_i386.o temp/decode_i386.o temp/interface.o temp/layer2.o temp/layer3.o temp/tabinit.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

