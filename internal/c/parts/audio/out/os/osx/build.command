cd "$(dirname "$0")"
clang -s -c -w -Wall ../../src/coreaudio.c -D AL_LIBTYPE_STATIC -o temp/coreaudio.o
clang -s -c -w -Wall ../../src/helpers.c -D AL_LIBTYPE_STATIC -o temp/helpers.o
clang -s -c -w -Wall ../../src/bs2b.c -D AL_LIBTYPE_STATIC -o temp/bs2b.o
clang -s -c -w -Wall ../../src/alAuxEffectSlot.c -D AL_LIBTYPE_STATIC -o temp/alAuxEffectSlot.o
clang -s -c -w -Wall ../../src/alBuffer.c -D AL_LIBTYPE_STATIC -o temp/alBuffer.o
clang -s -c -w -Wall ../../src/ALc.c -D AL_LIBTYPE_STATIC -o temp/ALc.o
clang -s -c -w -Wall ../../src/alcConfig.c -D AL_LIBTYPE_STATIC -o temp/alcConfig.o
clang -s -c -w -Wall ../../src/alcDedicated.c -D AL_LIBTYPE_STATIC -o temp/alcDedicated.o
clang -s -c -w -Wall ../../src/alcEcho.c -D AL_LIBTYPE_STATIC -o temp/alcEcho.o
clang -s -c -w -Wall ../../src/alcModulator.c -D AL_LIBTYPE_STATIC -o temp/alcModulator.o
clang -s -c -w -Wall ../../src/alcReverb.c -D AL_LIBTYPE_STATIC -o temp/alcReverb.o
clang -s -c -w -Wall ../../src/alcRing.c -D AL_LIBTYPE_STATIC -o temp/alcRing.o
clang -s -c -w -Wall ../../src/alcThread.c -D AL_LIBTYPE_STATIC -o temp/alcThread.o
clang -s -c -w -Wall ../../src/alEffect.c -D AL_LIBTYPE_STATIC -o temp/alEffect.o
clang -s -c -w -Wall ../../src/alError.c -D AL_LIBTYPE_STATIC -o temp/alError.o
clang -s -c -w -Wall ../../src/alExtension.c -D AL_LIBTYPE_STATIC -o temp/alExtension.o
clang -s -c -w -Wall ../../src/alFilter.c -D AL_LIBTYPE_STATIC -o temp/alFilter.o
clang -s -c -w -Wall ../../src/alListener.c -D AL_LIBTYPE_STATIC -o temp/alListener.o
clang -s -c -w -Wall ../../src/alSource.c -D AL_LIBTYPE_STATIC -o temp/alSource.o
clang -s -c -w -Wall ../../src/alState.c -D AL_LIBTYPE_STATIC -o temp/alState.o
clang -s -c -w -Wall ../../src/alThunk.c -D AL_LIBTYPE_STATIC -o temp/alThunk.o
clang -s -c -w -Wall ../../src/ALu.c -D AL_LIBTYPE_STATIC -o temp/ALu.o
clang -s -c -w -Wall ../../src/hrtf.c -D AL_LIBTYPE_STATIC -o temp/hrtf.o
clang -s -c -w -Wall ../../src/loopback.c -D AL_LIBTYPE_STATIC -o temp/loopback.o
clang -s -c -w -Wall ../../src/mixer.c -D AL_LIBTYPE_STATIC -o temp/mixer.o
clang -s -c -w -Wall ../../src/null.c -D AL_LIBTYPE_STATIC -o temp/null.o
clang -s -c -w -Wall ../../src/panning.c -D AL_LIBTYPE_STATIC -o temp/panning.o
clang -s -c -w -Wall ../../src/wave.c -D AL_LIBTYPE_STATIC -o temp/wave.o
ar rcs src.a temp/alAuxEffectSlot.o temp/alBuffer.o temp/ALc.o temp/alcConfig.o temp/alcDedicated.o temp/alcEcho.o temp/alcModulator.o temp/alcReverb.o temp/alcRing.o temp/alcThread.o temp/alEffect.o temp/alError.o temp/alExtension.o temp/alFilter.o temp/alListener.o temp/coreaudio.o temp/alSource.o temp/alState.o temp/alThunk.o temp/ALu.o temp/hrtf.o temp/loopback.o temp/mixer.o temp/null.o temp/panning.o temp/wave.o temp/helpers.o temp/bs2b.o
echo "Press any key to continue..."
Pause()
{
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty $OLDCONFIG
}
Pause
echo "Finished! Cancel this shell script or close the terminal"
Pause
Pause
Pause


####### added for OSX (above)
clang -s -c -w -Wall ../../src/coreaudio.c -D AL_LIBTYPE_STATIC -o temp/coreaudio.o


###### removed for osx
clang -s -c -w -Wall ../../src/alsa.c -D AL_LIBTYPE_STATIC -o temp/alsa.o


####Compiled but unrequired (using ALSA instead)####
clang -s -c -w -Wall ../../src/oss.c -D AL_LIBTYPE_STATIC -o temp/oss.o
temp/oss.o
clang -s -c -w -Wall ../../src/pulseaudio.c -D AL_LIBTYPE_STATIC -o temp/pulseaudio.o
temp/pulseaudio.o

####These all failed to compile in Ubuntu####
clang -s -c -w -Wall ../../src/solaris.c -D AL_LIBTYPE_STATIC -o temp/solaris.o
clang -s -c -w -Wall ../../src/sndio.c -D AL_LIBTYPE_STATIC -o temp/sndio.o
clang -s -c -w -Wall ../../src/portaudio.c -D AL_LIBTYPE_STATIC -o temp/portaudio.o
clang -s -c -w -Wall ../../src/coreaudio.c -D AL_LIBTYPE_STATIC -o temp/coreaudio.o
clang -s -c -w -Wall ../../src/opensl.c -D AL_LIBTYPE_STATIC -o temp/opensl.o

####These are Windows specific####
clang -s -c -w -Wall ../../src/dsound.c -D AL_LIBTYPE_STATIC -o temp/dsound.o
clang -s -c -w -Wall ../../src/mmdevapi.c -D AL_LIBTYPE_STATIC -o temp/mmdevapi.o
clang -s -c -w -Wall ../../src/winmm.c -D AL_LIBTYPE_STATIC -o temp/winmm.o

