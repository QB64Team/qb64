cd "$(dirname "$0")"

gcc -I../../../../ -I../../include -c ../../src/luke_mods.cpp -o temp/luke_mods.o
gcc -I../../../../ -I../../include -c ../../src/steve_mods.cpp -o temp/steve_mods.o
ar rcs src.a temp/steve_mods.o temp/luke_mods.o

echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause
