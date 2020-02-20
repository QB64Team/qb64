cd "$(dirname "$0")"
clang -s -c -w -Wall ../../src/Gamepad_macosx.c -o temp/Gamepad_macosx.o
clang -s -c -w -Wall ../../src/Gamepad_private.c -o temp/Gamepad_private.o
ar rcs src.a temp/Gamepad_private.o temp/Gamepad_macosx.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

