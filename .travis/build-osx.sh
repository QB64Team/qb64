#!/bin/sh

g++ --version

###### Part 1: Build old QB64 ######
echo "Preparing bootstrap:"
find . -type f -iname "*.command" -exec chmod +x {} \;
find . -type f -iname "*.a" -exec rm {} \;
find . -type f -iname "*.o" -exec rm {} \;

rm internal/temp/* 2> /dev/null

com_build() {
  cd internal/c/$1/os/osx
  echo "Building $2..."
  ./setup_build.command
  if [ $? -ne 0 ]; then
    echo "$2 build failed."
    exit 1
  fi
  echo "Done"
  cd - > /dev/null
} 

com_build "libqb" "libQB"
com_build "parts/video/font/ttf" "FreeType"
 
cp -r internal/source/* internal/temp/
cd internal/c
echo "Bootstrapping QB64..."
g++ -w qbx.cpp libqb/os/osx/libqb_setup.o parts/video/font/ttf/os/osx/src.o -framework GLUT -framework OpenGL -framework Cocoa -o ../../qb64_bootstrap
if [ $? -ne 0 ]; then
  echo "QB64 bootstrap failed"
  exit 1
fi
echo "Done"
cd - > /dev/null

###### Part 2: Build new QB64 from .bas sources ######
echo "Translating .bas source..."
echo From git `echo $TRAVIS_COMMIT | sed 's/\(.......\).*$/\1/'` > internal/version.txt
./qb64_bootstrap -x -z source/qb64.bas > /tmp/qb64-output
rm qb64_bootstrap
if [ `wc -l /tmp/qb64-output |awk '{print $1}'` -gt 2 ]; then
  cat /tmp/qb64-output
  rm /tmp/qb64-output
  exit 1
fi
echo "Done"

echo "Testing compile/link..."
# extract g++ line
cd internal/temp/
cpp_call=`awk '$1=="g++" {print $0}' < recompile_osx.command`

# run g++
cd ../c/
$cpp_call -o ../../qb64_testrun
if [ $? -ne 0 -o ! -f ../../qb64_testrun ]; then
  echo "Compile/link test failed"
  exit 1
fi
cd ../../
rm qb64_testrun
echo "Done"
exit
