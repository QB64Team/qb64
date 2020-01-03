#!/bin/bash

com_build() {
  cd internal/c/$1/os/lnx
  echo -n "Building $2..."
  ./setup_build.sh
  if [ $? -ne 0 ]; then
    echo "$2 build failed."
    exit 1
  fi
  echo "Done"
  cd - > /dev/null
} 

com_build "libqb" "libQB"
com_build "parts/video/font/ttf" "FreeType"
com_build "parts/core" "FreeGLUT"

cp -r internal/source/* internal/temp/
cd internal/c
echo -n "Bootstrapping QB64..."
g++ -w qbx.cpp libqb/os/lnx/libqb_setup.o parts/video/font/ttf/os/lnx/src.o parts/core/os/lnx/src.a -lGL -lGLU -lX11 -lcurses -lpthread -ldl -lrt -D FREEGLUT_STATIC -DDEPENDENCY_USER_MODS -o ../../qb64_bootstrap
if [ $? -ne 0 ]; then
  echo "QB64 bootstrap failed"
  exit 1
fi
echo "Done"
