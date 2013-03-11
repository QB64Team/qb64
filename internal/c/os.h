//OS/compiler detection
#ifdef WIN32
 #define QB64_WINDOWS
 #define QB64_BACKSLASH_FILESYSTEM
 #define NO_STDIO_REDIRECT
 #ifdef _MSC_VER
  #define QB64_MICROSOFT
 #else
  #define QB64_GCC
  #define QB64_MINGW
 #endif
#else
 #define QB64_LINUX
 #define QB64_GCC
 #ifdef __APPLE__
  #define QB64_MACOSX
 #endif
#endif

//common types
#ifndef QB64_OS_H_NO_TYPES
 #ifdef QB64_WINDOWS
  #define uint64 unsigned __int64
  #define uint32 unsigned __int32
  #define uint16 unsigned __int16
  #define uint8 unsigned __int8
  #define int64 __int64
  #define int32 __int32
  #define int16 __int16
  #define int8 __int8
 #else
  #define int64 int64_t
  #define int32 int32_t
  #define int16 int16_t
  #define int8 int8_t
  #define uint64 uint64_t
  #define uint32 uint32_t
  #define uint16 uint16_t
  #define uint8 uint8_t
 #endif
#endif

// Check windows
#if _WIN32 || _WIN64
#if _WIN64
#define QB64_64
#else
#define QB64_32
#endif
#endif
// Check GCC
#if __GNUC__
#if __x86_64__ || __ppc64__
#define QB64_64
#else
#define QB64_32
#endif
#endif

#ifndef QB64_OS_H_NO_TYPES
 #ifdef QB64_64
  #define ptrszint int64
  #define uptrszint uint64
  #define ptrsz 8
 #else
  #define ptrszint int32
  #define uptrszint uint32
  #define ptrsz 4
 #endif
#endif