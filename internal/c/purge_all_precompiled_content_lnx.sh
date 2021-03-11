#!/bin/sh

rm -f libqb/os/win/*.o
rm -f libqb/os/lnx/*.o

rm -f parts/core/os/win/src.a
rm -f parts/core/os/lnx/src.a
rm -f parts/core/os/win/temp/*.o
rm -f parts/core/os/lnx/temp/*.o

rm -f parts/audio/decode/mp3/os/win/src.a
rm -f parts/audio/decode/mp3/os/lnx/src.a
rm -f parts/audio/decode/mp3/os/win/temp/*.o
rm -f parts/audio/decode/mp3/os/lnx/temp/*.o

rm -f parts/audio/decode/ogg/os/win/src.o
rm -f parts/audio/decode/ogg/os/lnx/src.o
rm -f parts/audio/decode/ogg/os/win/temp/*.o
rm -f parts/audio/decode/ogg/os/lnx/temp/*.o

rm -f parts/audio/conversion/os/win/src.a
rm -f parts/audio/conversion/os/lnx/src.a
rm -f parts/audio/conversion/os/win/temp/*.o
rm -f parts/audio/conversion/os/lnx/temp/*.o

rm -f parts/audio/out/os/win/src.a
rm -f parts/audio/out/os/lnx/src.a
rm -f parts/audio/out/os/win/temp/*.o
rm -f parts/audio/out/os/lnx/temp/*.o

rm -f parts/video/font/ttf/os/win/src.o
rm -f parts/video/font/ttf/os/lnx/src.o
