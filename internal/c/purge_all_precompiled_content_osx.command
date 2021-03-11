cd "$(dirname "$0")"

rm -f libqb/os/win/*.o
rm -f libqb/os/osx/*.o

rm -f parts/core/os/win/src.a
rm -f parts/core/os/osx/src.a
rm -f parts/core/os/win/temp/*.o
rm -f parts/core/os/osx/temp/*.o

rm -f parts/audio/decode/mp3/os/win/src.a
rm -f parts/audio/decode/mp3/os/osx/src.a
rm -f parts/audio/decode/mp3/os/win/temp/*.o
rm -f parts/audio/decode/mp3/os/osx/temp/*.o

rm -f parts/audio/decode/ogg/os/win/src.o
rm -f parts/audio/decode/ogg/os/osx/src.o
rm -f parts/audio/decode/ogg/os/win/temp/*.o
rm -f parts/audio/decode/ogg/os/osx/temp/*.o

rm -f parts/audio/conversion/os/win/src.a
rm -f parts/audio/conversion/os/osx/src.a
rm -f parts/audio/conversion/os/win/temp/*.o
rm -f parts/audio/conversion/os/osx/temp/*.o

rm -f parts/audio/out/os/win/src.a
rm -f parts/audio/out/os/osx/src.a
rm -f parts/audio/out/os/win/temp/*.o
rm -f parts/audio/out/os/osx/temp/*.o

rm -f parts/video/font/ttf/os/win/src.o
rm -f parts/video/font/ttf/os/osx/src.o
