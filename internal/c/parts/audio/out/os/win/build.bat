..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\winmm.c -D AL_LIBTYPE_STATIC -o temp\winmm.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\null.c -D AL_LIBTYPE_STATIC -o temp\null.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\loopback.c -D AL_LIBTYPE_STATIC -o temp\loopback.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\dsound.c -D AL_LIBTYPE_STATIC -o temp\dsound.o

..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\panning.c -D AL_LIBTYPE_STATIC -o temp\panning.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\mixer.c -D AL_LIBTYPE_STATIC -o temp\mixer.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\hrtf.c -D AL_LIBTYPE_STATIC -o temp\hrtf.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\helpers.c -D AL_LIBTYPE_STATIC -o temp\helpers.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\bs2b.c -D AL_LIBTYPE_STATIC -o temp\bs2b.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\ALu.c -D AL_LIBTYPE_STATIC -o temp\ALu.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alcThread.c -D AL_LIBTYPE_STATIC -o temp\alcThread.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alcRing.c -D AL_LIBTYPE_STATIC -o temp\alcRing.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alcReverb.c -D AL_LIBTYPE_STATIC -o temp\alcReverb.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alcModulator.c -D AL_LIBTYPE_STATIC -o temp\alcModulator.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alcEcho.c -D AL_LIBTYPE_STATIC -o temp\alcEcho.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alcDedicated.c -D AL_LIBTYPE_STATIC -o temp\alcDedicated.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alcConfig.c -D AL_LIBTYPE_STATIC -o temp\alcConfig.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\ALc.c -D AL_LIBTYPE_STATIC -o temp\ALc.o

..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alThunk.c -D AL_LIBTYPE_STATIC -o temp\alThunk.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alState.c -D AL_LIBTYPE_STATIC -o temp\alState.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alSource.c -D AL_LIBTYPE_STATIC -o temp\alSource.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alListener.c -D AL_LIBTYPE_STATIC -o temp\alListener.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alFilter.c -D AL_LIBTYPE_STATIC -o temp\alFilter.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alExtension.c -D AL_LIBTYPE_STATIC -o temp\alExtension.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alError.c -D AL_LIBTYPE_STATIC -o temp\alError.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alEffect.c -D AL_LIBTYPE_STATIC -o temp\alEffect.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alBuffer.c -D AL_LIBTYPE_STATIC -o temp\alBuffer.o
..\..\..\..\..\%MINGW%\bin\gcc -s -c -w -Wall ..\..\src\alAuxEffectSlot.c -D AL_LIBTYPE_STATIC -o temp\alAuxEffectSlot.o

..\..\..\..\..\%MINGW%\bin\ar rcs src.a temp\winmm.o temp\null.o temp\loopback.o temp\dsound.o        temp\panning.o temp\mixer.o temp\hrtf.o temp\helpers.o temp\bs2b.o temp\ALu.o temp\alcThread.o temp\alcRing.o temp\alcReverb.o temp\alcModulator.o temp\alcEcho.o temp\alcDedicated.o temp\alcConfig.o        temp\ALc.o temp\alThunk.o temp\alState.o temp\alSource.o temp\alListener.o temp\alFilter.o temp\alExtension.o temp\alError.o temp\alEffect.o temp\alBuffer.o temp\alAuxEffectSlot.o

PAUSE


