@echo off
cd %0\..\
cd ../..
echo C++ Debugging: 2014_02_22__19_09_30_build2__qb64.exe using gdb.exe
echo Debugger commands:
echo After the debugger launches type 'run' to start your program
echo After your program crashes type 'list' to find where the problem is and fix/report it
echo Type 'quit' to exit
echo (the GDB debugger has many other useful commands, this advice is for beginners)
pause
internal\c\c_compiler\bin\gdb.exe "2014_02_22__19_09_30_build2__qb64.exe"
pause
