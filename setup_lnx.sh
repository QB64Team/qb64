#!/bin/bash
#QB64 Installer -- Shell Script -- Matt Kilgore 2013
#Version 4 -- April 4, 2013
#Compiles:
#	GL : .978
#	SDL: .954


#This checks the currently installed packages for the one's QB64 needs
#And runs the package manager to install them if that is the case
pkg_install() {
  #Search
  packages_to_install=
  for pkg in $pkg_list; do
    if [ -z "$(echo "$installed_packages" | grep $pkg)" ]; then
      packages_to_install="$packages_to_install $pkg"
    fi
  done
  if [ -n "$packages_to_install" ]; then
    echo "Installing required packages. If Prompted to, please enter your password"
    $installer_command $packages_to_install
  fi

}

#Set this to 1 to make it download everything
DOWNLOAD=


#Set this to 1 to compile SDL instead (Only works if DOWNLOAD=1)
SDL=

if [ "$DOWNLOAD" == "1" ]; then
  #Various URL's for downloads
  QB64_URL="http://www.qb64.net/qb64v0978-lnx.tar.gz"
  QB64_SDL_URL="http://www.qb64.net/qb64v0954-lnx.tar.gz"
  QB64_ICON_URL="http://www.qb64.net/qb64icon32.png"

  #Name for download QB64
  QB64_ZIP_NAME=qb64.tar.gz
  #Will be downloaded to current directory
  QB64_ICON_PATH="."
  GET_WGET="wget"
else
  GET_WGET=
  #Path to Icon
  #Relative Path to icon -- Don't include beginning or trailing '/'
  QB64_ICON_PATH="internal/source"
fi

#Name of the Icon picture
QB64_ICON_NAME="qb64icon32.png"

DISTRO=

if [ -f ./qb64 ]; then
  echo "Removing old QB64 files in preperation for installing new version..."
  rm ./qb64
  rm -fr ./internal
  echo "Done. Installing QB64 now."
fi

lsb_command=`which lsb_release 2> /dev/null`
if [ -z "$lsb_command" ]; then
  lsb_command=`which lsb_release 2> /dev/null`
fi

#Outputs from lsb_command:

#Arch Linux	 = arch
#Debian    	 = debian
#Fedora		 = Fedora
#KUbuntu	 = ubuntu
#LUbuntu  	 = ubuntu
#Linux Mint	 = linuxmint
#Ubuntu		 = ubuntu
#Slackware	 = slackware
#XUbuntu	 = ubuntu

if [ -n "$lsb_command" ]; then
  DISTRO=`$lsb_command -si | tr '[:upper:]' '[:lower:]'`
elif [ -e /etc/arch-release ]; then
  DISTRO=arch
elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
  DISTRO=debian
elif [ -e /etc/fedora-release ]; then
  DISTRO=fedora
elif [ -e /etc/redhat-release ]; then
  DISTRO=redhat
elif [ -e /etc/centos-release ]; then
  DISTRO=centos
fi

#Find and install packages
if [ "$DISTRO" == "arch" ]; then
  echo "ArchLinux detected."
  if [ "$SDL" == "1" ]; then
    pkg_list="gcc sdl sdl_image sdl_mixer sdl_net sdl_ttf $GET_WGET"
  else
    pkg_list="gcc $GET_WGET"
  fi
  installed_packages=`pacman -Q`
  installer_command="sudo pacman -S "
  pkg_install
elif [ "$DISTRO" == "linuxmint" ] || [ "$DISTRO" == "ubuntu" ] || [ "$DISTRO" == "debian" ]; then
  echo "Debian based distro detected."
  if [ "$SDL" == "1" ]; then
    pkg_list="g++ libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-net1.2-dev libsdl-ttf2.0-dev libsdl1.2-dev $GET_WGET"
  else
    pkg_list="g++ mesa-common-dev libglu1-mesa-dev libasound2-dev $GET_WGET"
  fi
  installed_packages=`dpkg -l`
  installer_command="sudo apt-get -y install "
  pkg_install
elif [ "$DISTRO" == "fedora" ] || [ "$DISTRO" == "redhat" ] || [ "$DISTRO" == "centos" ]; then
  echo "Fedora/Redhat based distro detected."
  if [ "$SDL" == "1" ]; then
    pkg_list="gcc-c++ SDL-devel SDL_image-devel SDL_mixer-devel SDL_net-devel SDL_ttf-devel $GET_WGET"
  else
    pkg_list="gcc-c++ mesa-libGLU-devel alsa-lib-devel $GET_WGET"
  fi
  installed_packages=`yum list installed`
  installer_command="sudo yum install "
  pkg_install
elif [ -z "$DISTRO" ]; then
  echo "Unable to detect distro, skipping package installation"
  echo "Please be aware that for QB64 to compile, you will need the following installed:"
  echo "  OpenGL developement libraries"
  echo "  ALSA development libraries"
  echo "  GNU C++ Compiler (g++)"
fi

if [ "$DOWNLOAD" == "1" ]; then
  echo "Downloading QB64..."
  if [ "$SDL" == "1" ]; then
    wget $QB64_SDL_URL -O $QB64_ZIP_NAME
  else
    wget $QB64_URL -O $QB64_ZIP_NAME
  fi
  if [ ! -f $QB64_ICON_NAME ]; then
    echo "Grabbing QB64 Icon..."
    wget $QB64_ICON_URL
  fi
  echo "Uncompressing to directory..."
  #strip-components=1 removes the leading ./qb64 directory from the archive
  tar --strip-components=1 -zxvf $QB64_ZIP_NAME >/dev/null
fi

echo "Compiling and installing QB64..."
if [ "$SDL" == "1" ]; then

  ### SDL Installation process
  cp ./internal/source/* ./internal/temp/
  cd ./internal/c
  g++ -c -w -Wall libqbx.cpp -o libqbx_lnx.o  `sdl-config --cflags`
  g++ -w libqbx_lnx.o qbx.cpp `sdl-config --cflags --libs` -lSDL_mixer -lSDL_ttf -lSDL_net -lSDL_image -lX11 -o ../../qb64
  cd ../..
else

  ### GL installation process
  find . -name "*.sh" -exec chmod +x {} \;
  find . -type f -iname "*.a" -exec rm -f {} \;
  find . -type f -iname "*.o" -exec rm -f {} \;
  rm ./internal/temp/*

  echo "Building library 'LibQB'"
  cd internal/c/libqb/os/lnx
  rm -f libqb_setup.o
  ./setup_build.sh
  cd ../../../../..

  echo "Building library 'FreeType'"
  cd internal/c/parts/video/font/ttf/os/lnx
  rm -f src.o
  ./setup_build.sh
  cd ../../../../../../../..

  echo "Building library 'Core:FreeGLUT'"
  cd internal/c/parts/core/os/lnx
  rm -f src.a
  ./setup_build.sh
  cd ../../../../../..

  echo "Building 'QB64'"
  cp ./internal/source/* ./internal/temp/
  cd internal/c
  g++ -w qbx.cpp libqb/os/lnx/libqb_setup.o parts/video/font/ttf/os/lnx/src.o parts/core/os/lnx/src.a -lGL -lGLU -lX11 -lpthread -ldl -lrt -D FREEGLUT_STATIC -o ../../qb64
  cd ../..
fi

if [ -e "./qb64" ]; then
  echo "Done compiling!!"

  echo "Creating ./run_qb64.sh script..."
  _pwd=`pwd`
  echo "#!/bin/sh" > ./run_qb64.sh
  echo "cd $_pwd" >> ./run_qb64.sh
  echo "./qb64 &" >> ./run_qb64.sh
  
  chmod +x ./run_qb64.sh
  #chmod -R 777 ./
  echo "Adding QB64 menu entry..."
  cat > ~/.local/share/applications/qb64.desktop <<EOF
[Desktop Entry]
Name=QB64 Programming IDE
GenericName=QB64 Programming IDE
Exec=$_pwd/run_qb64.sh
Icon=$_pwd/$QB64_ICON_PATH/$QB64_ICON_NAME
Terminal=false
Type=Application
Categories=Development;IDE;
Path=$_pwd
StartupNotify=false
EOF

  echo "Running QB64..."
  ./qb64 &
  echo "QB64 is located in this folder:"
  echo "`pwd`"
  echo "There is a ./run_qb64.sh script in this folder that should let you run qb64 if using the executable directly isn't working."
  echo 
  echo "You should also find a QB64 option in the Programming/Development section of your menu you can use."
else
  ### QB64 didn't compile
  echo "It appears that the qb64 executable file was not created, this is usually an indication of a compile failure (You probably saw lots of error messages pop up on the screen)"
  echo "Usually these are due to missing packages needed for compilation. If you're not running a distro supported by this compiler, please note you will need to install the packages listed above."
  echo "If you need help, please feel free to post on the QB64 Forums detailing what happened and what distro you are using."
fi
echo
echo "Thank you for using the QB64 installer."
