#ifdef WIN32
 #include "..\..\..\..\os.h"
#else
 #include "../../../../os.h"
#endif

#ifdef QB64_WINDOWS

/* Set to 1 if compiling for Win32 */
#define OS_IS_WIN32 1
/* The size of `double', as computed by sizeof. */
#define SIZEOF_DOUBLE 10
/* The size of `float', as computed by sizeof. */
#define SIZEOF_FLOAT 4
/* The size of `int', as computed by sizeof. */
#define SIZEOF_INT 4
/* The size of `long', as computed by sizeof. */
#define SIZEOF_LONG 4
/* Target processor clips on negative float to int conversion. */
#define CPU_CLIPS_NEGATIVE 1
/* Target processor clips on positive float to int conversion. */
#define CPU_CLIPS_POSITIVE 0
/* Set to 1 if the compile is GNU GCC. */
#define COMPILER_IS_GCC 1
/* Target processor is big endian. */
#define CPU_IS_BIG_ENDIAN
/* Target processor is little endian. */
#define CPU_IS_LITTLE_ENDIAN
/* Major version of GCC or 3 otherwise. */
#define GCC_MAJOR_VERSION
/* Define to 1 if you have the `alarm' function. */
#define HAVE_ALARM 1
/* Define to 1 if you have the `calloc' function. */
#define HAVE_CALLOC 1
/* Define to 1 if you have the `ceil' function. */
#define HAVE_CEIL 1
/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 0
/* Set to 1 if you have libfftw3. */
#define HAVE_FFTW3 0
/* Define to 1 if you have the `floor' function. */
#define HAVE_FLOOR 1
/* Define to 1 if you have the `fmod' function. */
#define HAVE_FMOD 1
/* Define to 1 if you have the `free' function. */
#define HAVE_FREE 1
/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1
/* Define to 1 if you have the `m' library (-lm). */
#define HAVE_LIBM 1
/* Define if you have C99's lrint function. */
#define HAVE_LRINT 1
/* Define if you have C99's lrintf function. */
#define HAVE_LRINTF 1
/* Define to 1 if you have the `malloc' function. */
#define HAVE_MALLOC 1
/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1
/* Define to 1 if you have the `memmove' function. */
#define HAVE_MEMMOVE 1
/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1
/* Define if you have signal SIGALRM. */
#define HAVE_SIGALRM 1
/* Define to 1 if you have the `signal' function. */
#define HAVE_SIGNAL 1
/* Set to 1 if you have libsndfile. */
#define HAVE_SNDFILE 0
/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1
/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1
/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1
/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1
/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1
/* Define to 1 if you have the <sys/times.h> header file. */
#define HAVE_SYS_TIMES_H 1
/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1
/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1
/* Define to the sub-directory in which libtool stores uninstalled libraries. */
#define LT_OBJDIR ""
/* Define to 1 if your C compiler doesn't accept -c and -o together. */
#define NO_MINUS_C_MINUS_O 0
/* Name of package */
#define PACKAGE "SRC"
/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""
/* Define to the full name of this package. */
#define PACKAGE_NAME "SRC"
/* Define to the full name and version of this package. */
#define PACKAGE_STRING "SRC"
/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "SRC"
/* Define to the home page for this package. */
#define PACKAGE_URL "SRC"
/* Define to the version of this package. */
#define PACKAGE_VERSION "SRC"
/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS
/* Version number of package */
#define VERSION

#endif



#ifndef QB64_WINDOWS

/* Target processor clips on negative float to int conversion. */
#define CPU_CLIPS_NEGATIVE 1
/* Target processor clips on positive float to int conversion. */
#define CPU_CLIPS_POSITIVE 0
/* Set to 1 if compiling for Win32 */
#define OS_IS_WIN32 0
#ifdef QB64_64
 /* The size of `double', as computed by sizeof. */
 #define SIZEOF_DOUBLE 10
 /* The size of `float', as computed by sizeof. */
 #define SIZEOF_FLOAT 4
 /* The size of `int', as computed by sizeof. */
 #define SIZEOF_INT 4
 /* The size of `long', as computed by sizeof. */
 #define SIZEOF_LONG 8
#endif
#ifdef QB64_32
 /* The size of `double', as computed by sizeof. */
 #define SIZEOF_DOUBLE 10
 /* The size of `float', as computed by sizeof. */
 #define SIZEOF_FLOAT 4
 /* The size of `int', as computed by sizeof. */
 #define SIZEOF_INT 4
 /* The size of `long', as computed by sizeof. */
 #define SIZEOF_LONG 4
#endif
/* Set to 1 if the compile is GNU GCC. */
#define COMPILER_IS_GCC 1
/* Target processor is big endian. */
////#define CPU_IS_BIG_ENDIAN
/* Target processor is little endian. */
#define CPU_IS_LITTLE_ENDIAN
/* Major version of GCC or 3 otherwise. */
#define GCC_MAJOR_VERSION
/* Define to 1 if you have the `alarm' function. */
#define HAVE_ALARM 1
/* Define to 1 if you have the `calloc' function. */
#define HAVE_CALLOC 1
/* Define to 1 if you have the `ceil' function. */
#define HAVE_CEIL 1
/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 0
/* Set to 1 if you have libfftw3. */
#define HAVE_FFTW3 0
/* Define to 1 if you have the `floor' function. */
#define HAVE_FLOOR 1
/* Define to 1 if you have the `fmod' function. */
#define HAVE_FMOD 1
/* Define to 1 if you have the `free' function. */
#define HAVE_FREE 1
/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1
/* Define to 1 if you have the `m' library (-lm). */
#define HAVE_LIBM 1
/* Define if you have C99's lrint function. */
#define HAVE_LRINT 1
/* Define if you have C99's lrintf function. */
#define HAVE_LRINTF 1
/* Define to 1 if you have the `malloc' function. */
#define HAVE_MALLOC 1
/* Define to 1 if you have the `memcpy' function. */
#define HAVE_MEMCPY 1
/* Define to 1 if you have the `memmove' function. */
#define HAVE_MEMMOVE 1
/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1
/* Define if you have signal SIGALRM. */
#define HAVE_SIGALRM 1
/* Define to 1 if you have the `signal' function. */
#define HAVE_SIGNAL 1
/* Set to 1 if you have libsndfile. */
////#define HAVE_SNDFILE 0
/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1
/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1
/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1
/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1
/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1
/* Define to 1 if you have the <sys/times.h> header file. */
#define HAVE_SYS_TIMES_H 1
/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1
/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1
/* Define to the sub-directory in which libtool stores uninstalled libraries. */
#define LT_OBJDIR ""
/* Define to 1 if your C compiler doesn't accept -c and -o together. */
#define NO_MINUS_C_MINUS_O 0
/* Name of package */
#define PACKAGE "SRC"
/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""
/* Define to the full name of this package. */
#define PACKAGE_NAME "SRC"
/* Define to the full name and version of this package. */
#define PACKAGE_STRING "SRC"
/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "SRC"
/* Define to the home page for this package. */
#define PACKAGE_URL "SRC"
/* Define to the version of this package. */
#define PACKAGE_VERSION "SRC"
/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS
/* Version number of package */
#define VERSION

#endif
