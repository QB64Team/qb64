#!/bin/sh
gcc -I../../../../ -DFREEGLUT_STATIC -I../../include -c ../../src/luke_mods.cpp -o temp/luke_mods.o
gcc -I../../../../ -DFREEGLUT_STATIC -I../../include -c ../../src/steve_mods.cpp -o temp/steve_mods.o
ar rcs src.a temp/steve_mods.o temp/luke_mods.o
