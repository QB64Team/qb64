#!/bin/sh
gcc -s -c -w -Wall ../../src/helpers.c -D AL_LIBTYPE_STATIC -o temp/helpers.o
gcc -s -c -w -Wall ../../src/bs2b.c -D AL_LIBTYPE_STATIC -o temp/bs2b.o
gcc -s -c -w -Wall ../../src/alAuxEffectSlot.c -D AL_LIBTYPE_STATIC -o temp/alAuxEffectSlot.o
gcc -s -c -w -Wall ../../src/alBuffer.c -D AL_LIBTYPE_STATIC -o temp/alBuffer.o
gcc -s -c -w -Wall ../../src/ALc.c -D AL_LIBTYPE_STATIC -o temp/ALc.o
gcc -s -c -w -Wall ../../src/alcConfig.c -D AL_LIBTYPE_STATIC -o temp/alcConfig.o
gcc -s -c -w -Wall ../../src/alcDedicated.c -D AL_LIBTYPE_STATIC -o temp/alcDedicated.o
gcc -s -c -w -Wall ../../src/alcEcho.c -D AL_LIBTYPE_STATIC -o temp/alcEcho.o
gcc -s -c -w -Wall ../../src/alcModulator.c -D AL_LIBTYPE_STATIC -o temp/alcModulator.o
gcc -s -c -w -Wall ../../src/alcReverb.c -D AL_LIBTYPE_STATIC -o temp/alcReverb.o
gcc -s -c -w -Wall ../../src/alcRing.c -D AL_LIBTYPE_STATIC -o temp/alcRing.o
gcc -s -c -w -Wall ../../src/alcThread.c -D AL_LIBTYPE_STATIC -o temp/alcThread.o
gcc -s -c -w -Wall ../../src/alEffect.c -D AL_LIBTYPE_STATIC -o temp/alEffect.o
gcc -s -c -w -Wall ../../src/alError.c -D AL_LIBTYPE_STATIC -o temp/alError.o
gcc -s -c -w -Wall ../../src/alExtension.c -D AL_LIBTYPE_STATIC -o temp/alExtension.o
gcc -s -c -w -Wall ../../src/alFilter.c -D AL_LIBTYPE_STATIC -o temp/alFilter.o
gcc -s -c -w -Wall ../../src/alListener.c -D AL_LIBTYPE_STATIC -o temp/alListener.o
gcc -s -c -w -Wall ../../src/alsa.c -D AL_LIBTYPE_STATIC -o temp/alsa.o
gcc -s -c -w -Wall ../../src/alSource.c -D AL_LIBTYPE_STATIC -o temp/alSource.o
gcc -s -c -w -Wall ../../src/alState.c -D AL_LIBTYPE_STATIC -o temp/alState.o
gcc -s -c -w -Wall ../../src/alThunk.c -D AL_LIBTYPE_STATIC -o temp/alThunk.o
gcc -s -c -w -Wall ../../src/ALu.c -D AL_LIBTYPE_STATIC -o temp/ALu.o
gcc -s -c -w -Wall ../../src/hrtf.c -D AL_LIBTYPE_STATIC -o temp/hrtf.o
gcc -s -c -w -Wall ../../src/loopback.c -D AL_LIBTYPE_STATIC -o temp/loopback.o
gcc -s -c -w -Wall ../../src/mixer.c -D AL_LIBTYPE_STATIC -o temp/mixer.o
gcc -s -c -w -Wall ../../src/null.c -D AL_LIBTYPE_STATIC -o temp/null.o
gcc -s -c -w -Wall ../../src/panning.c -D AL_LIBTYPE_STATIC -o temp/panning.o
gcc -s -c -w -Wall ../../src/wave.c -D AL_LIBTYPE_STATIC -o temp/wave.o
ar rcs src.a temp/alAuxEffectSlot.o temp/alBuffer.o temp/ALc.o temp/alcConfig.o temp/alcDedicated.o temp/alcEcho.o temp/alcModulator.o temp/alcReverb.o temp/alcRing.o temp/alcThread.o temp/alEffect.o temp/alError.o temp/alExtension.o temp/alFilter.o temp/alListener.o temp/alsa.o temp/alSource.o temp/alState.o temp/alThunk.o temp/ALu.o temp/hrtf.o temp/loopback.o temp/mixer.o temp/null.o temp/panning.o temp/wave.o temp/helpers.o temp/bs2b.o
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

####Compiled but unrequired (using ALSA instead)####
gcc -s -c -w -Wall ../../src/oss.c -D AL_LIBTYPE_STATIC -o temp/oss.o
temp/oss.o
gcc -s -c -w -Wall ../../src/pulseaudio.c -D AL_LIBTYPE_STATIC -o temp/pulseaudio.o
temp/pulseaudio.o

####These all failed to compile in Ubuntu####
gcc -s -c -w -Wall ../../src/solaris.c -D AL_LIBTYPE_STATIC -o temp/solaris.o
gcc -s -c -w -Wall ../../src/sndio.c -D AL_LIBTYPE_STATIC -o temp/sndio.o
gcc -s -c -w -Wall ../../src/portaudio.c -D AL_LIBTYPE_STATIC -o temp/portaudio.o
gcc -s -c -w -Wall ../../src/coreaudio.c -D AL_LIBTYPE_STATIC -o temp/coreaudio.o
gcc -s -c -w -Wall ../../src/opensl.c -D AL_LIBTYPE_STATIC -o temp/opensl.o

####These are Windows specific####
gcc -s -c -w -Wall ../../src/dsound.c -D AL_LIBTYPE_STATIC -o temp/dsound.o
gcc -s -c -w -Wall ../../src/mmdevapi.c -D AL_LIBTYPE_STATIC -o temp/mmdevapi.o
gcc -s -c -w -Wall ../../src/winmm.c -D AL_LIBTYPE_STATIC -o temp/winmm.o

