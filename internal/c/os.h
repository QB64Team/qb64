/* Provide some OS/compiler macros.
    * QB64_WINDOWS: Is this a Windows system?
    * QB64_LINUX: Is this a Linux system?
    * QB64_MACOSX: Is this MacOSX, or MacOS or whatever Apple calls it now?
    * QB64_UNIX: Is this a Unix-flavoured system?
    *
    * QB64_BACKSLASH_FILESYSTEM: Does this system use \ for file paths (as opposed to /)?
    * QB64_MICROSOFT: Are we compiling with Visual Studio?
    * QB64_GCC: Are we compiling with gcc?
    * QB64_MINGW: Are we compiling with MinGW, specifically? (Set in addition to QB64_GCC)
    *
    * QB64_32: A 32bit system (the default)
    * QB64_64: A 64bit system (assumes all Macs are 64 bit)
*/
#ifdef WIN32
    #define QB64_WINDOWS
    #define QB64_BACKSLASH_FILESYSTEM
    #ifdef _MSC_VER
        //Do we even support non-mingw compilers on Windows?
        #define QB64_MICROSOFT
        #else
        #define QB64_GCC
        #define QB64_MINGW
    #endif
    #elif defined(__APPLE__)
    #define QB64_MACOSX
    #define QB64_UNIX
    #define QB64_GCC
    #elif defined(__linux__)
    #define QB64_LINUX
    #define QB64_UNIX
    #define QB64_GCC
    #else
    #error "Unknown system; refusing to build. Edit os.h if needed"
#endif

#if defined(_WIN64) || defined(__x86_64__) || defined(__ppc64__) || defined(QB64_MACOSX) || defined(__aarch64__)
    #define QB64_64
    #else
    #define QB64_32
#endif

#if !defined(i386) && !defined(__x86_64__)
    #define QB64_NOT_X86
#endif

/* common types (not quite an include guard, but allows an including
    * file to not have these included.
    *
    * Should this be adapted to check for each type before defining?
*/
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
