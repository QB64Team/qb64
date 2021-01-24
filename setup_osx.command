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

pushd internal/c/libqb >/dev/null
find . -type f -iname "*.a" -exec rm -f {} \;
find . -type f -iname "*.o" -exec rm -f {} \;
popd >/dev/null

pushd internal/c/parts >/dev/null
find . -type f -iname "*.a" -exec rm -f {} \;
find . -type f -iname "*.o" -exec rm -f {} \;
popd >/dev/null

rm ./internal/temp/*

if [ -z "$(which clang++)" ]; then
  echo "Apple's C++ compiler not found."
  echo "Attempting to install Apple's Command Line Tools for Xcode..."
  echo "After installation is finished, run this setup script again."
  xcode-select --install
  Pause
  exit 1
fi

echo "Building library 'LibQB'"
pushd internal/c/libqb/os/osx >/dev/null
rm -f libqb_setup.o
./setup_build.command
if [ ! -f ./libqb_setup.o ]; then
  echo "Compilation of ./internal/c/libqb/os/osx/libqb_setup.o failed!"
  Pause
  exit 1
fi
popd >/dev/null

echo "Building library 'FreeType'"
pushd internal/c/parts/video/font/ttf/os/osx >/dev/null
rm -f src.o
./setup_build.command
if [ ! -f ./src.o ]; then
  echo "Compilation of ./internal/c/parts/video/font/ttf/os/osx/src.o failed!"
  Pause
  exit 1
fi
popd >/dev/null

echo "Building 'QB64' (~3 min)"
cp ./internal/source/* ./internal/temp/
pushd internal/c >/dev/null
clang++ -w qbx.cpp libqb/os/osx/libqb_setup.o parts/video/font/ttf/os/osx/src.o -framework GLUT -framework OpenGL -framework Cocoa -o ../../qb64
popd >/dev/null

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
