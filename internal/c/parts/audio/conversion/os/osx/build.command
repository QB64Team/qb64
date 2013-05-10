cd "$(dirname "$0")"
gcc -c ../../src/samplerate.c -o temp/samplerate.o
gcc -c ../../src/src_linear.c -o temp/src_linear.o
gcc -c ../../src/src_sinc.c -o temp/src_sinc.o
gcc -c ../../src/src_zoh.c -o temp/src_zoh.o
ar rcs src.a temp/samplerate.o temp/src_linear.o temp/src_sinc.o temp/src_zoh.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

