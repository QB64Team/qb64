# QB64

<p align="center">
<img src="https://qb64.org/images/QB64icon1.3small.png"/>
</p

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/QB64Team/qb64/issues)


QB64 is a modern extended BASIC+OpenGL language that retains QB4.5/QBasic compatibility and compiles native binaries for Windows (XP and up), Linux and macOS.

# Table of Contents
1. [Installation](#Installation)
    1. [Windows](##Windows)
    2. [Mac](##Mac)
    3. [Linux](##Linux)

2.  [Usage](#Usage)
3.  [Additional Info](#Additional_Info)

# Installation [](#Installation)

## Windows [](##Windows)

Download the respective Zip (or 7Zip) file for your version of Windows over at:  https://github.com/QB64Team/qb64/releases

Once you have downloaded your file, make sure to Extract the file contents to "C:\" or to a folder with full write permissions.

Failing to do so will reuslt in QB64 failing to comple your source.

Additionally, the Default editor that launches will produce IDE module errors, before proceeding to hang.

``` IDE MODULE ERROR (module: ide_methods, on line: 10223)```

``` IDE MODULE ERROR (module: ide_methods, on line: 7109)```

*Some users may need to whitelist QB64 within their anti-malware software*

## Mac [](##Mac)
Before installing QB64 make sure to install the Xcode comand line tools with
```bash
xcode-select --install
```

You can then download QB64 over at: https://github.com/QB64Team/qb64/releases

Once you have downloaded the executable, it is advisable for QB64 to be placed in the Applications folder or some other memorable location. You should then run ```./setup_osx.command```

## Linux [](##Linux)
For Linux make sure to downloiad the appropriate package for your Linux Distribution. Afer downloading tha package run ```./setup_lnx.sh```

Dependencies should automatically install. These are: OpenGL, ALSA and the GNU C++ Compiler.

# Usage [](#Usage)
Run the QB64 executable or launch script to launch the default IDE. From there you are able to write Basic scripts and compile them.

Additionally, if you do not wish to use the integrated IDE and to only compile your program, you can use the following commands:

```QB64 -x yourfile.BAS``` (compiles using the console only)

```QB64 -c yourfile.BAS -o destination_path\destination executable_name.exe``` (compiles the .BAS file and outputs the executable to a separate folder)

# Additional Information [](#Additional_Info)
More about it at our wiki: www.qb64.org/wiki

We have a community forum at: www.qb64.org/forum

We tweet from [@QB64Team](https://twitter.com/QB64team)

Find us on Discord: http://discord.qb64.org

Find us on IRC: http://irc.qb64.org/
