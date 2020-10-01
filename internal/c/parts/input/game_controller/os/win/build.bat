..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\Gamepad_windows_mm.c -o temp\Gamepad_windows_mm.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\Gamepad_private.c -o temp\Gamepad_private.o
..\..\..\..\..\%MINGW%\bin\ar rcs src.a temp\Gamepad_private.o temp\Gamepad_windows_mm.o
pause