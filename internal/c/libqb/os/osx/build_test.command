cd "$(dirname "$0")"
clang++ -c -w -Wall ../../../libqb.mm -D DEPENDENCY_AUDIO_OUT -D DEPENDENCY_AUDIO_DECODE -D DEPENDENCY_AUDIO_CONVERSION -o libqb_test_only.o
echo "Press any key to continue"
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause

