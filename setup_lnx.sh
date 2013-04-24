#!/bin/sh
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
echo "QB64 Setup"
echo ""

if [ -z "$(which g++)" ]; then
  echo "GNU C++ compiler not detected (g++)"
  echo "Please install it before running QB64 setup."
  Pause
  exit 1
fi

find . -name "*.sh" -exec chmod +x {} \;
find . -type f -iname "*.a" -exec rm -f {} \;
find . -type f -iname "*.o" -exec rm -f {} \;
rm /internal/temp/*

echo "Building library 'LibQB'"
cd internal/c/libqb/os/lnx
rm -f libqb_setup.o
./setup_build.sh
if [ ! -f ./libqb_setup.o ]; then
  echo "Compilation of ./internal/c/libqb/os/lnx/libqb_setup.o failed!"
  Pause
  exit 1
fi
cd ../../../../..

echo "Building library 'FreeType'"
cd internal/c/parts/video/font/ttf/os/lnx
rm -f src.o
./setup_build.sh
if [ ! -f ./src.o ]; then
  echo "Compilation of ./internal/c/parts/video/font/ttf/os/lnx/src.o failed!"
  Pause
  exit 1
fi
cd ../../../../../../../..

echo "Building library 'Core:FreeGLUT'"
cd internal/c/parts/core/os/lnx
rm -f src.a
./setup_build.sh
if [ ! -f ./src.a ]; then
  echo "Compilation of ./internal/c/parts/core/os/lnx/src.a failed!"
  Pause
  exit 1
fi
cd ../../../../../..

echo "Building 'QB64'"
cp ./internal/source/* ./internal/temp/
cd internal/c
g++ -w qbx.cpp libqb/os/lnx/libqb_setup.o parts/video/font/ttf/os/lnx/src.o parts/core/os/lnx/src.a -lGL -lGLU -lX11 -lpthread -ldl -lrt -D FREEGLUT_STATIC -o ../../qb64
cd ../..

echo ""
if [ -f ./qb64 ]; then
  echo "Launching 'QB64'"
  ./qb64
  echo ""
  echo "Note: 'qb64' is located in same folder as this setup program."
  echo "Press any key to continue..."
  Pause
else
  echo "Compilaton of QB64 failed!"
  Pause
  exit 1
fi

