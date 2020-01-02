cd "$(dirname "$0")"

rm libqb/os/win/*.o
rm libqb/os/lnx/*.o

rm parts/core/os/win/src.a
rm parts/core/os/lnx/src.a
rm parts/core/os/win/temp/*.o
rm parts/core/os/lnx/temp/*.o

rm parts/audio/decode/mp3/os/win/src.a
rm parts/audio/decode/mp3/os/lnx/src.a
rm parts/audio/decode/mp3/os/win/temp/*.o
rm parts/audio/decode/mp3/os/lnx/temp/*.o

rm parts/audio/decode/ogg/os/win/src.o
rm parts/audio/decode/ogg/os/lnx/src.o
rm parts/audio/decode/ogg/os/win/temp/*.o
rm parts/audio/decode/ogg/os/lnx/temp/*.o

rm parts/audio/conversion/os/win/src.a
rm parts/audio/conversion/os/lnx/src.a
rm parts/audio/conversion/os/win/temp/*.o
rm parts/audio/conversion/os/lnx/temp/*.o

rm parts/audio/out/os/win/src.a
rm parts/audio/out/os/lnx/src.a
rm parts/audio/out/os/win/temp/*.o
rm parts/audio/out/os/lnx/temp/*.o

rm parts/video/font/ttf/os/win/src.o
rm parts/video/font/ttf/os/lnx/src.o