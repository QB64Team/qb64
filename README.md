# QB64

<p align="center">
<img src="https://www.qb64.org/images/githubstrip.png"/>
</p

QB64 is a modern extended BASIC+OpenGL language that retains QB4.5/QBasic compatibility and compiles native binaries for Windows (XP and up), Linux and macOS.
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/QB64Team/qb64/issues)

# Table of Contents
1. [Installation](#Installation)
    1. [Windows](#Windows)
    2. [macOS](#macOS)
    3. [Linux](#Linux)

2.  [Usage](#Usage)
3.  [Additional Info](#Additional_Info)

# Installation <a name="Installation"></a>
Download the appropriate package for your operating system over at https://github.com/QB64Team/qb64/releases.

<a name="Windows"></a>
## Windows

Make sure to extract the package contents to a folder with full write permissions (failing to do so may result in IDE or compilation errors).

* It is advisable to to whitelist the QB64 folder in your antivirus/antimalware software *

<a name="macOS"></a>
## macOS
Before using QB64 make sure to install the Xcode command line tools with:
```bash
xcode-select --install
```

The package comes with a precompiled `qb64` binary that will run as is in macOS Catalina. For older versions of macOS, run ```./setup_osx.command``` to compile QB64 for your OS version.

<a name="Linux"></a>
## Linux
The package comes with a precompiled `qb64` binary that will run as is in most Debian-based distributions. For other distributions, compile QB64 with ```./setup_lnx.sh```.

Dependencies should be automatically installed. Required packages include OpenGL, ALSA and the GNU C++ Compiler.

<a name="Usage"></a>
# Usage
Run the QB64 executable to launch the IDE, which you can use to edit your .BAS files. From there, hit F5 to compile and run your code.

To generate a binary without running it, hit F11.

Additionally, if you do not wish to use the integrated IDE and to only compile your program, you can use the following command-line calls:

```qb64 -c yourfile.bas```

```qb64 -c yourfile.bas -o outputname.exe```

Replacing `-c` with `-x` will compile without opening a separate compiler window.


<a name="Additional_Info"></a>
# Additional Information
More about QB64 at our wiki: www.qb64.org/wiki

We have a community forum at: www.qb64.org/forum

We tweet from [@QB64Team](https://twitter.com/QB64team)

Find us on Discord: http://discord.qb64.org
