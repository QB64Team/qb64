#ifndef CONFIG_H
#define CONFIG_H

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

#define ALSOFT_VERSION "1.12.854"
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

