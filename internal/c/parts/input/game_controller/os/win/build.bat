..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\Gamepad_windows_mm.c -o temp\Gamepad_windows_mm.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\Gamepad_private.c -o temp\Gamepad_private.o
..\..\..\..\..\c_compiler\bin\ar rcs src.a temp\Gamepad_private.o temp\Gamepad_windows_mm.o
pause