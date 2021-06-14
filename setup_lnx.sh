#!/bin/bash
#QB64 Installer -- Shell Script -- Matt Kilgore 2013
#Version 5 -- January 2020

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
    echo "Installing required packages. If prompted to, please enter your password."
    $installer_command $packages_to_install
  fi

}



#Make sure we're not running as root
if [ $EUID == "0" ]; then
  echo "You are trying to run this script as root. This is highly unrecommended."
  echo "This script will prompt you for your sudo password if needed to install packages."
  exit 1
fi

GET_WGET=
#Path to Icon
#Relative Path to icon -- Don't include beginning or trailing '/'
QB64_ICON_PATH="internal/source"

#Name of the Icon picture
QB64_ICON_NAME="qb64icon32.png"

DISTRO=

lsb_command=`which lsb_release 2> /dev/null`
if [ -z "$lsb_command" ]; then
  lsb_command=`which lsb_release 2> /dev/null`
fi

#Outputs from lsb_command:

#Arch Linux  = arch
#Debian      = debian
#Fedora      = Fedora
#KUbuntu     = ubuntu
#LUbuntu     = ubuntu
#Linux Mint  = linuxmint
#Ubuntu      = ubuntu
#Slackware   = slackware
#VoidLinux   = voidlinux
#XUbuntu     = ubuntu
#Zorin       = Zorin
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
  pkg_list="gcc zlib xorg-xmessage $GET_WGET"
  installed_packages=`pacman -Q`
  installer_command="sudo pacman -S "
  pkg_install
elif [ "$DISTRO" == "linuxmint" ] || [ "$DISTRO" == "ubuntu" ] || [ "$DISTRO" == "debian" ] || [ "$DISTRO" == "zorin" ]; then
  echo "Debian based distro detected."
  pkg_list="g++ x11-utils mesa-common-dev libglu1-mesa-dev libasound2-dev zlib1g-dev $GET_WGET"
  installed_packages=`dpkg -l`
  installer_command="sudo apt-get -y install "
  pkg_install
elif [ "$DISTRO" == "fedora" ] || [ "$DISTRO" == "redhat" ] || [ "$DISTRO" == "centos" ]; then
  echo "Fedora/Redhat based distro detected."
  pkg_list="gcc-c++ xmessage mesa-libGLU-devel alsa-lib-devel zlib-devel $GET_WGET"
  installed_packages=`yum list installed`
  installer_command="sudo yum install "
  pkg_install
elif [ "$DISTRO" == "voidlinux" ]; then
   echo "VoidLinux detected."
   pkg_list="gcc xmessage glu-devel zlib-devel alsa-lib-devel $GET_WGET"
   installed_packages=`xbps-query -l |grep -v libgcc`
   installer_command="sudo xbps-install -Sy "
   pkg_install

elif [ -z "$DISTRO" ]; then
  echo "Unable to detect distro, skipping package installation"
  echo "Please be aware that for QB64 to compile, you will need the following installed:"
  echo "  OpenGL developement libraries"
  echo "  ALSA development libraries"
  echo "  GNU C++ Compiler (g++)"
  echo "  xmessage (x11-utils)"
  echo "  zlib"
fi

echo "Compiling and installing QB64..."

### Build process
find . -name "*.sh" -exec chmod +x {} \;
find internal/c/parts -type f -iname "*.a" -exec rm -f {} \;
find internal/c/parts -type f -iname "*.o" -exec rm -f {} \;
find internal/c/libqb -type f -iname "*.o" -exec rm -f {} \;
rm ./internal/temp/*

echo "Building library 'LibQB'"
pushd internal/c/libqb/os/lnx >/dev/null
rm -f libqb_setup.o
./setup_build.sh
popd >/dev/null

echo "Building library 'FreeType'"
pushd internal/c/parts/video/font/ttf/os/lnx >/dev/null
rm -f src.o
./setup_build.sh
popd >/dev/null

echo "Building library 'Core:FreeGLUT'"
pushd internal/c/parts/core/os/lnx >/dev/null
rm -f src.a
./setup_build.sh
popd >/dev/null

echo "Building 'QB64'"
cp -r ./internal/source/* ./internal/temp/
pushd internal/c >/dev/null
g++ -no-pie -w qbx.cpp libqb/os/lnx/libqb_setup.o parts/video/font/ttf/os/lnx/src.o parts/core/os/lnx/src.a -lGL -lGLU -lX11 -lpthread -ldl -lrt -D FREEGLUT_STATIC -o ../../qb64
popd

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
  echo "Also, please tell them the exact contents of this next line:"
  echo "DISTRO: $DISTRO"
fi
echo
echo "Thank you for using the QB64 installer."
