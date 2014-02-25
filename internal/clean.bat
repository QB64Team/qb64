@echo off

echo This batch is an admin tool to return QB64 to its pre-setup state
pause

echo Purging temp folders
rmdir /s /q temp,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9 2>nul
echo Replacing main temp folder
md temp

echo Replacing dummy file in temp folder to maintain directory structure
copy source\temp.bin temp\temp.bin


echo Pruning source folder
del source\undo2.bin 2>nul
del source\recompile.bat 2>nul
del source\debug.bat 2>nul
del source\files.txt 2>nul
del source\paths.txt 2>nul
del source\root.txt 2>nul
del source\bookmarks.bin 2>nul
del source\recent.bin 2>nul

echo Culling precompiled libraries
del /s c\libqb\*.o 2>nul
del /s c\libqb\*.a 2>nul
del /s c\parts\*.o 2>nul
del /s c\parts\*.a 2>nul

echo Culling temporary copies of qbx.cpp, such as qbx2.cpp
del c\qbx2.cpp,c\qbx3.cpp,c\qbx4.cpp,c\qbx5.cpp,c\qbx6.cpp,c\qbx7.cpp,c\qbx8.cpp,c\qbx9.cpp 2>nul

pause
