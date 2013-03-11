#define QB64_OS_H_NO_TYPES
#ifdef WIN32
 #include "..\..\..\..\os.h"
#else
 #include "../../../../os.h"
#endif

#ifndef CONFIG_H
#define CONFIG_H

#define ALSOFT_VERSION "?.??.???"


#ifdef QB64_WINDOWS

#define HAVE__CONTROLFP
#define HAVE_POWF
#define HAVE_FABSF
#define HAVE_ACOSF
#define HAVE___INT64
#define HAVE_SQRTF
#define HAVE_DSOUND
#define HAVE_STAT
#define HAVE_ATANF
#define HAVE_FLOAT_H
#define HAVE_WINMM
#define HAVE_GCC_DESTRUCTOR
#define SIZEOF_LONG 4
#define SIZEOF_LONG_LONG 8
#define SIZEOF_UINT 4
#define SIZEOF_VOIDP 4
#define AL_BUILD_LIBRARY
#define isnan(x) (x != x)
#define snprintf _snprintf
#define strncasecmp _strnicmp
#define strcasecmp _stricmp

#endif


#ifndef QB64_WINDOWS

#ifdef QB64_MACOSX



#ifdef QB64_64
/* Define to the size of a long int type */
#define SIZEOF_LONG 4
/* Define to the size of a long long int type */
#define SIZEOF_LONG_LONG 8
#endif
#ifdef QB64_32
/* Define to the size of a long int type */
#define SIZEOF_LONG 4
/* Define to the size of a long long int type */
#define SIZEOF_LONG_LONG 8
#endif
#include <pthread.h>

//!!!!!
//#define PTHREAD_MUTEX_RECURSIVE PTHREAD_MUTEX_RECURSIVE_NP 

/* API declaration export attribute */
#define AL_API  __attribute__((visibility("protected")))
#define ALC_API __attribute__((visibility("protected")))
/* Define to the library version */
#define ALSOFT_VERSION "1.14"

/* Define if we have the ALSA backend */
//!!!!!
//#define HAVE_ALSA

/* Define if we have the OSS backend */
////#define HAVE_OSS
/* Define if we have the Solaris backend */
/* #undef HAVE_SOLARIS */
/* Define if we have the SndIO backend */
/* #undef HAVE_SNDIO */
/* Define if we have the MMDevApi backend */
/* #undef HAVE_MMDEVAPI */
/* Define if we have the DSound backend */
/* #undef HAVE_DSOUND */
/* Define if we have the Windows Multimedia backend */
/* #undef HAVE_WINMM */
/* Define if we have the PortAudio backend */
////#define HAVE_PORTAUDIO
/* Define if we have the PulseAudio backend */
////#define HAVE_PULSEAUDIO
/* Define if we have the CoreAudio backend */

//!!!!!
#define HAVE_COREAUDIO

/* Define if we have the OpenSL backend */
/* #undef HAVE_OPENSL */
/* Define if we have the Wave Writer backend */
////#define HAVE_WAVE
/* Define if we have dlfcn.h */
#define HAVE_DLFCN_H
/* Define if we have the stat function */
#define HAVE_STAT
/* Define if we have the powf function */
#define HAVE_POWF
/* Define if we have the sqrtf function */
#define HAVE_SQRTF
/* Define if we have the cosf function */
#define HAVE_COSF
/* Define if we have the sinf function */
#define HAVE_SINF
/* Define if we have the acosf function */
#define HAVE_ACOSF
/* Define if we have the asinf function */
#define HAVE_ASINF
/* Define if we have the atanf function */
#define HAVE_ATANF
/* Define if we have the atan2f function */
#define HAVE_ATAN2F
/* Define if we have the fabsf function */
#define HAVE_FABSF
/* Define if we have the log10f function */
#define HAVE_LOG10F
/* Define if we have the floorf function */
#define HAVE_FLOORF
/* Define if we have the strtof function */
#define HAVE_STRTOF
/* Define if we have stdint.h */
#define HAVE_STDINT_H
/* Define if we have the __int64 type */
/* #undef HAVE___INT64 */
/* Define if we have GCC's destructor attribute */
#define HAVE_GCC_DESTRUCTOR
/* Define if we have GCC's format attribute */
#define HAVE_GCC_FORMAT
/* Define if we have pthread_np.h */
/* #undef HAVE_PTHREAD_NP_H */
/* Define if we have arm_neon.h */
/* #undef HAVE_ARM_NEON_H */
/* Define if we have guiddef.h */
/* #undef HAVE_GUIDDEF_H */
/* Define if we have guiddef.h */
/* #undef HAVE_INITGUID_H */
/* Define if we have ieeefp.h */
/* #undef HAVE_IEEEFP_H */
/* Define if we have float.h */
#define HAVE_FLOAT_H
/* Define if we have fpu_control.h */
////#define HAVE_FPU_CONTROL_H
/* Define if we have fenv.h */
#define HAVE_FENV_H
/* Define if we have fesetround() */
////#define HAVE_FESETROUND
/* Define if we have _controlfp() */
/* #undef HAVE__CONTROLFP */
/* Define if we have pthread_setschedparam() */
////#define HAVE_PTHREAD_SETSCHEDPARAM
/* Define if we have the restrict keyword */
/* #undef HAVE_RESTRICT */
/* Define if we have the __restrict keyword */
////#define HAVE___RESTRICT




#else

//not macosx
#ifdef QB64_64
/* Define to the size of a long int type */
#define SIZEOF_LONG 4
/* Define to the size of a long long int type */
#define SIZEOF_LONG_LONG 8
#endif
#ifdef QB64_32
/* Define to the size of a long int type */
#define SIZEOF_LONG 4
/* Define to the size of a long long int type */
#define SIZEOF_LONG_LONG 8
#endif
#include <pthread.h>
#define PTHREAD_MUTEX_RECURSIVE PTHREAD_MUTEX_RECURSIVE_NP 
/* API declaration export attribute */
#define AL_API  __attribute__((visibility("protected")))
#define ALC_API __attribute__((visibility("protected")))
/* Define to the library version */
#define ALSOFT_VERSION "1.14"
/* Define if we have the ALSA backend */
#define HAVE_ALSA
/* Define if we have the OSS backend */
////#define HAVE_OSS
/* Define if we have the Solaris backend */
/* #undef HAVE_SOLARIS */
/* Define if we have the SndIO backend */
/* #undef HAVE_SNDIO */
/* Define if we have the MMDevApi backend */
/* #undef HAVE_MMDEVAPI */
/* Define if we have the DSound backend */
/* #undef HAVE_DSOUND */
/* Define if we have the Windows Multimedia backend */
/* #undef HAVE_WINMM */
/* Define if we have the PortAudio backend */
////#define HAVE_PORTAUDIO
/* Define if we have the PulseAudio backend */
////#define HAVE_PULSEAUDIO
/* Define if we have the CoreAudio backend */
/* #undef HAVE_COREAUDIO */
/* Define if we have the OpenSL backend */
/* #undef HAVE_OPENSL */
/* Define if we have the Wave Writer backend */
////#define HAVE_WAVE
/* Define if we have dlfcn.h */
#define HAVE_DLFCN_H
/* Define if we have the stat function */
#define HAVE_STAT
/* Define if we have the powf function */
#define HAVE_POWF
/* Define if we have the sqrtf function */
#define HAVE_SQRTF
/* Define if we have the cosf function */
#define HAVE_COSF
/* Define if we have the sinf function */
#define HAVE_SINF
/* Define if we have the acosf function */
#define HAVE_ACOSF
/* Define if we have the asinf function */
#define HAVE_ASINF
/* Define if we have the atanf function */
#define HAVE_ATANF
/* Define if we have the atan2f function */
#define HAVE_ATAN2F
/* Define if we have the fabsf function */
#define HAVE_FABSF
/* Define if we have the log10f function */
#define HAVE_LOG10F
/* Define if we have the floorf function */
#define HAVE_FLOORF
/* Define if we have the strtof function */
#define HAVE_STRTOF
/* Define if we have stdint.h */
#define HAVE_STDINT_H
/* Define if we have the __int64 type */
/* #undef HAVE___INT64 */
/* Define if we have GCC's destructor attribute */
#define HAVE_GCC_DESTRUCTOR
/* Define if we have GCC's format attribute */
#define HAVE_GCC_FORMAT
/* Define if we have pthread_np.h */
/* #undef HAVE_PTHREAD_NP_H */
/* Define if we have arm_neon.h */
/* #undef HAVE_ARM_NEON_H */
/* Define if we have guiddef.h */
/* #undef HAVE_GUIDDEF_H */
/* Define if we have guiddef.h */
/* #undef HAVE_INITGUID_H */
/* Define if we have ieeefp.h */
/* #undef HAVE_IEEEFP_H */
/* Define if we have float.h */
#define HAVE_FLOAT_H
/* Define if we have fpu_control.h */
////#define HAVE_FPU_CONTROL_H
/* Define if we have fenv.h */
#define HAVE_FENV_H
/* Define if we have fesetround() */
////#define HAVE_FESETROUND
/* Define if we have _controlfp() */
/* #undef HAVE__CONTROLFP */
/* Define if we have pthread_setschedparam() */
////#define HAVE_PTHREAD_SETSCHEDPARAM
/* Define if we have the restrict keyword */
/* #undef HAVE_RESTRICT */
/* Define if we have the __restrict keyword */
////#define HAVE___RESTRICT
#endif //not macosx
#endif //not windows


#endif //CONFIG_H
