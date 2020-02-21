cd "$(dirname "$0")"

rm libqb/os/win/*.o
rm libqb/os/osx/*.o

rm parts/core/os/win/src.a
rm parts/core/os/osx/src.a
rm parts/core/os/win/temp/*.o
rm parts/core/os/osx/temp/*.o

rm parts/audio/decode/mp3/os/win/src.a
rm parts/audio/decode/mp3/os/osx/src.a
rm parts/audio/decode/mp3/os/win/temp/*.o
rm parts/audio/decode/mp3/os/osx/temp/*.o

rm parts/audio/decode/ogg/os/win/src.o
rm parts/audio/decode/ogg/os/osx/src.o
rm parts/audio/decode/ogg/os/win/temp/*.o
rm parts/audio/decode/ogg/os/osx/temp/*.o

rm parts/audio/conversion/os/win/src.a
rm parts/audio/conversion/os/osx/src.a
rm parts/audio/conversion/os/win/temp/*.o
rm parts/audio/conversion/os/osx/temp/*.o

rm parts/audio/out/os/win/src.a
rm parts/audio/out/os/osx/src.a
rm parts/audio/out/os/win/temp/*.o
rm parts/audio/out/os/osx/temp/*.o

rm parts/video/font/ttf/os/win/src.o
rm parts/video/font/ttf/os/osx/src.o