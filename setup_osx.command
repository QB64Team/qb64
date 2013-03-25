cd "$(dirname "$0")"
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
echo "QB64 Setup"
echo ""

find . -name "*.command" -exec chmod +x {} \;
find . -type f -iname "*.a" -exec rm -f {} \;
find . -type f -iname "*.o" -exec rm -f {} \;
rm /internal/temp/*

if [ -z "$(which g++)" ]; then
  echo "GNU C++ compiler not detected (g++)"
  echo "Please install Apple Xcode and Apple Command Line Tools for Xcode"
  echo "before launching QB64 setup."
  Pause
  exit 1
fi

echo "Building library 'LibQB'"
cd internal/c/libqb/os/osx
rm -f libqb_setup.o
./setup_build.command
if [ ! -f ./libqb_setup.o ]; then
  echo "Compilation of ./internal/c/libqb/os/osx/libqb_setup.o failed!"
  Pause
  exit 1
fi
cd ../../../../..

echo "Building library 'FreeType'"
cd internal/c/parts/video/font/ttf/os/osx
rm -f src.o
./setup_build.command
if [ ! -f ./src.o ]; then
  echo "Compilation of ./internal/c/parts/video/font/ttf/os/osx/src.o failed!"
  Pause
  exit 1
fi
cd ../../../../../../../..

echo "Building 'QB64' (~3 min)"
cp ./internal/source/* ./internal/temp/
cd internal/c
g++ -w qbx.cpp libqb/os/osx/libqb_setup.o parts/video/font/ttf/os/osx/src.o -framework GLUT -framework OpenGL -framework Cocoa -o ../../qb64
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
  echo "Compilation of QB64 failed!"
  Pause
  exit 1
fi

