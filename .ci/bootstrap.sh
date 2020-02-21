#!/bin/bash

OS=$1

com_build() {
    cd internal/c/$1/os/$OS
    echo -n "Building $2..."
    if [[ $OS == "osx" ]]; then
        ./setup_build.command
    else
        ./setup_build.sh
    fi
    if [ $? -ne 0 ]; then
      echo "$2 build failed."
      exit 1
    fi
    echo "Done"
    cd - > /dev/null
} 

com_build "libqb" "libQB"
com_build "parts/video/font/ttf" "FreeType"
if [[ $OS == "lnx" ]]; then
    com_build "parts/core" "FreeGLUT"
fi

cp -r internal/source/* internal/temp/
cd internal/c
echo -n "Bootstrapping QB64..."
if [[ $OS == "osx" ]]; then
    clang++ -w qbx.cpp libqb/os/osx/libqb_setup.o parts/video/font/ttf/os/osx/src.o -framework GLUT -framework OpenGL -framework Cocoa -lcurses -o ../../qb64_bootstrap
else
    g++ -w qbx.cpp libqb/os/lnx/libqb_setup.o parts/video/font/ttf/os/lnx/src.o parts/core/os/lnx/src.a -lGL -lGLU -lX11 -lcurses -lpthread -ldl -lrt -D FREEGLUT_STATIC -DDEPENDENCY_USER_MODS -o ../../qb64_bootstrap
fi

if [ $? -ne 0 ]; then
  echo "QB64 bootstrap failed"
  exit 1
fi
echo "Done"
