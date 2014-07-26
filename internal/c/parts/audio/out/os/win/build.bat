..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\winmm.c -D AL_LIBTYPE_STATIC -o temp\winmm.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\null.c -D AL_LIBTYPE_STATIC -o temp\null.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\loopback.c -D AL_LIBTYPE_STATIC -o temp\loopback.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\dsound.c -D AL_LIBTYPE_STATIC -o temp\dsound.o

..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\panning.c -D AL_LIBTYPE_STATIC -o temp\panning.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\mixer.c -D AL_LIBTYPE_STATIC -o temp\mixer.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\hrtf.c -D AL_LIBTYPE_STATIC -o temp\hrtf.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\helpers.c -D AL_LIBTYPE_STATIC -o temp\helpers.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\bs2b.c -D AL_LIBTYPE_STATIC -o temp\bs2b.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\ALu.c -D AL_LIBTYPE_STATIC -o temp\ALu.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alcThread.c -D AL_LIBTYPE_STATIC -o temp\alcThread.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alcRing.c -D AL_LIBTYPE_STATIC -o temp\alcRing.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alcReverb.c -D AL_LIBTYPE_STATIC -o temp\alcReverb.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alcModulator.c -D AL_LIBTYPE_STATIC -o temp\alcModulator.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alcEcho.c -D AL_LIBTYPE_STATIC -o temp\alcEcho.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alcDedicated.c -D AL_LIBTYPE_STATIC -o temp\alcDedicated.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alcConfig.c -D AL_LIBTYPE_STATIC -o temp\alcConfig.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\ALc.c -D AL_LIBTYPE_STATIC -o temp\ALc.o

..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alThunk.c -D AL_LIBTYPE_STATIC -o temp\alThunk.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alState.c -D AL_LIBTYPE_STATIC -o temp\alState.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alSource.c -D AL_LIBTYPE_STATIC -o temp\alSource.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alListener.c -D AL_LIBTYPE_STATIC -o temp\alListener.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alFilter.c -D AL_LIBTYPE_STATIC -o temp\alFilter.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alExtension.c -D AL_LIBTYPE_STATIC -o temp\alExtension.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alError.c -D AL_LIBTYPE_STATIC -o temp\alError.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alEffect.c -D AL_LIBTYPE_STATIC -o temp\alEffect.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alBuffer.c -D AL_LIBTYPE_STATIC -o temp\alBuffer.o
..\..\..\..\..\c_compiler\bin\gcc -s -c -w -Wall ..\..\src\alAuxEffectSlot.c -D AL_LIBTYPE_STATIC -o temp\alAuxEffectSlot.o

..\..\..\..\..\c_compiler\bin\ar rcs src.a temp\winmm.o temp\null.o temp\loopback.o temp\dsound.o        temp\panning.o temp\mixer.o temp\hrtf.o temp\helpers.o temp\bs2b.o temp\ALu.o temp\alcThread.o temp\alcRing.o temp\alcReverb.o temp\alcModulator.o temp\alcEcho.o temp\alcDedicated.o temp\alcConfig.o        temp\ALc.o temp\alThunk.o temp\alState.o temp\alSource.o temp\alListener.o temp\alFilter.o temp\alExtension.o temp\alError.o temp\alEffect.o temp\alBuffer.o temp\alAuxEffectSlot.o

pause


