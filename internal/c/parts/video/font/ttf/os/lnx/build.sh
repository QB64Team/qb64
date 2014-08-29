#!/bin/sh
g++ -s -c -w -Wall ../../src/freetypeamalgam.c -o src.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

