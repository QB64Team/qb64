cd "$(dirname "$0")"
clang -c ../../src/resample.c -o temp/resample.o
ar rcs src.a temp/resample.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

