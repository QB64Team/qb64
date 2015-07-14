dnl Process this file with autoconf to produce a configure script. -*-m4-*-

dnl The package_version file will be automatically synced to the git revision
dnl by the update_version script when configured in the repository, but will
dnl remain constant in tarball releases unless it is manually edited.
m4_define([CURRENT_VERSION],
          m4_esyscmd([ ./update_version 2>/dev/null || true
                       if test -e package_version; then
                           . ./package_version
                           printf "$PACKAGE_VERSION"
                       else
                           printf "unknown"
                       fi ]))

AC_INIT([opus-tools],[CURRENT_VERSION],[opus@xiph.org])
AC_CONFIG_SRCDIR([src/opusenc.c])
AC_CONFIG_MACRO_DIR([m4])

dnl enable silent rules on automake 1.11 and later
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AM_INIT_AUTOMAKE([1.11 foreign no-define])
AM_MAINTAINER_MODE([enable])

AC_CANONICAL_HOST
AM_PROG_CC_C_O

AC_PROG_CC_C99
AC_C_BIGENDIAN
AC_C_CONST
AC_C_INLINE

#Use a hacked up version of autoconf's AC_C_RESTRICT because it's not
#strong enough a test to detect old buggy versions of GCC (e.g. 2.95.3)
#Note: Both this and the test for variable-size arrays below are also
#      done by AC_PROG_CC_C99, but not thoroughly enough apparently.
AC_CACHE_CHECK([for C/C++ restrict keyword], ac_cv_c_restrict,
  [ac_cv_c_restrict=no
   # The order here caters to the fact that C++ does not require restrict.
   for ac_kw in __restrict __restrict__ _Restrict restrict; do
     AC_COMPILE_IFELSE([AC_LANG_PROGRAM(
      [[typedef int * int_ptr;
	int foo (int_ptr $ac_kw ip, int * $ac_kw baz[]) {
	return ip[0];
       }]],
      [[int s[1];
	int * $ac_kw t = s;
	t[0] = 0;
	return foo(t, (void *)0)]])],
      [ac_cv_c_restrict=$ac_kw])
     test "$ac_cv_c_restrict" != no && break
   done
  ])

AH_VERBATIM([restrict],
[/* Define to the equivalent of the C99 'restrict' keyword, or to
   nothing if this is not supported.  Do not define if restrict is
   supported directly.  */
#undef restrict
/* Work around a bug in Sun C++: it does not support _Restrict or
   __restrict__, even though the corresponding Sun C compiler ends up with
   "#define restrict _Restrict" or "#define restrict __restrict__" in the
   previous line.  Perhaps some future version of Sun C++ will work with
   restrict; if so, hopefully it defines __RESTRICT like Sun C does.  */
#if defined __SUNPRO_CC && !defined __RESTRICT
# define _Restrict
# define __restrict__
#endif])

case $ac_cv_c_restrict in
   restrict) ;;
   no) AC_DEFINE([restrict], []) ;;
   *)  AC_DEFINE_UNQUOTED([restrict], [$ac_cv_c_restrict]) ;;
esac

AC_MSG_CHECKING(for C99 variable-size arrays)
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([],
                   [[static int x; char a[++x]; a[sizeof a - 1] = 0; int N; return a[0];]])],
    [ has_var_arrays=yes
      AC_DEFINE([VAR_ARRAYS], [1], [Use C99 variable-size arrays])
    ],[
      has_var_arrays=no
    ])
AC_MSG_RESULT([$has_var_arrays])

AC_ARG_ENABLE([assertions],
    [AS_HELP_STRING([--enable-assertions],[enable additional software error checking])],,
    [enable_assertions=no])

AS_IF([test "$enable_assertions" = "yes"], [
  AC_DEFINE([ENABLE_ASSERTIONS], [1], [Assertions])
])

if test "$CFLAGS" = "-g -O2"; then
    saved_CFLAGS="$CFLAGS"
    CFLAGS="-O3 -ffast-math"
    AC_MSG_CHECKING([if ${CC} supports -O3 -g -ffast-math])
    AC_COMPILE_IFELSE([AC_LANG_SOURCE([[char foo;]])],
        [ AC_MSG_RESULT([yes])
          saved_CFLAGS="-O3 -g -ffast-math"
        ],[
          AC_MSG_RESULT([no])
        ])
    CFLAGS="$saved_CFLAGS"
fi

LT_LIB_M
AC_CHECK_LIB([winmm], [main])

dnl check for pkg-config itself so we don't try the m4 macro without pkg-config
AC_CHECK_PROG(HAVE_PKG_CONFIG, pkg-config, yes)

dnl check for Ogg
AS_IF([test "$HAVE_PKG_CONFIG" = "yes"],
  dnl first try via pkg-config
 [PKG_CHECK_MODULES([OGG],[ogg >= 1.3])],
 [
  dnl fall back to the old school test
  XIPH_PATH_OGG(, AC_MSG_ERROR([
    libogg is required to build this package!
    please see http://www.xiph.org/ for how to
    obtain a copy.
  ]))
  saved_CFLAGS="$CFLAGS"
  saved_LIBS="$LIBS"
  CFLAGS="$CFLAGS $OGG_CFLAGS"
  LIBS="$LIBS $OGG_LIBS"
  AC_CHECK_FUNC([ogg_stream_flush_fill],,[
    AC_MSG_ERROR([newer libogg version (1.3 or later) required])
  ])
  CFLAGS="$saved_CFLAGS"
  LIBS="$saved_LIBS"
 ])

dnl check for Opus
AS_IF([test "$HAVE_PKG_CONFIG" = "yes"],
 [PKG_CHECK_MODULES([OPUS],[opus >= 1.0.3])],
 [
  dnl fall back to the old school test
  XIPH_PATH_OPUS(, AC_MSG_ERROR([
    Opus is required to build this package!
    please see http://opus-codec.org/ for how to
    obtain a copy.
  ]))
 ])

dnl check for OSS
HAVE_OSS=no
AC_CHECK_HEADERS([sys/soundcard.h soundcard.h machine/soundcard.h],[
  HAVE_OSS=yes
  break
])

dnl check for sndio
AC_CHECK_LIB([sndio], [sio_open])

if test "$HAVE_OSS" != "yes" && test "$ac_cv_lib_sndio_sio_open" != "yes"; then
  AC_MSG_WARN([Audio support not found -- no direct audio output in opusdec])
fi

dnl check for flac
AC_ARG_WITH([flac],
    [AS_HELP_STRING([--without-flac],[disable FLAC support])],,
    [with_flac=yes])

AS_IF([test "$with_flac" = "yes"],
 [
  AS_IF([test "$HAVE_PKG_CONFIG" = "yes"],
   [PKG_CHECK_MODULES([FLAC],[flac >= 1.1.3])],
   [
    dnl fall back to AC_CHECK_LIB
    AC_CHECK_LIB([FLAC],[FLAC__stream_decoder_init_ogg_stream],
      [
        FLAC_LIBS="-lFLAC"
      ],
      [
        AC_MSG_ERROR([
          FLAC 1.1.3 or later is required to build this package!
          Please install it or configure with --disable-flac.
        ])
      ]
    )
    AC_CHECK_HEADER([FLAC/stream_decoder.h],,
      [
        AC_MSG_ERROR([
          FLAC headers are required to build this package!
          Please install the development version of FLAC
          or configure with --disable-flac.
        ])
      ]
    )
   ])

  AC_DEFINE([HAVE_LIBFLAC],[1],[FLAC])
 ])

dnl check for pcap
AC_CHECK_LIB([pcap], [pcap_open_live], [
  AC_DEFINE([HAVE_PCAP], 1, [Define if building with libpcap support])
  LIBPCAP="-lpcap"
])
AC_SUBST(LIBPCAP)

on_x86=no
case "$host_cpu" in
i[[3456]]86 | x86_64)
  on_x86=yes
  ;;
esac

dnl check for sse
AC_ARG_ENABLE([sse],
    [AS_HELP_STRING([--enable-sse],[Build binaries that require SSE])],,
    [enable_sse=no])

AS_IF([test "$on_x86" = "yes" && test "$enable_sse" = "yes"],
 [
  saved_CFLAGS="$CFLAGS"
  CFLAGS="$CFLAGS -msse"
  AC_MSG_CHECKING([if ${CC} supports -msse])
  AC_LINK_IFELSE([AC_LANG_PROGRAM([],[[char foo;]])],
    [ AC_MSG_RESULT([yes]) ],
    [
      AC_MSG_RESULT([no])
      enable_sse=no
      CFLAGS="$saved_CFLAGS"
    ])
 ])

dnl Enable stack-protector-all only on x86 where it's well supported.
dnl on some platforms it causes crashes. Hopefully the OS's default's
dnl include this on platforms that work but have been missed here.
AC_ARG_ENABLE([stack-protector],
    [AS_HELP_STRING([--disable-stack-protector],[Disable compiler stack hardening])],,
    [
      AS_IF([test "$ac_cv_c_compiler_gnu" = "yes" && test "$on_x86" = "yes"],
            [enable_stack_protector=yes],[enable_stack_protector=no])
    ])

AS_IF([test "$enable_stack_protector" = "yes"],
 [
  saved_CFLAGS="$CFLAGS"
  CFLAGS="$CFLAGS -fstack-protector-all"
  AC_MSG_CHECKING([if ${CC} supports -fstack-protector-all])
  AC_LINK_IFELSE([AC_LANG_PROGRAM([],[[char foo;]])],
    [ AC_MSG_RESULT([yes]) ],
    [
      AC_MSG_RESULT([no])
      enable_stack_protector=no
      CFLAGS="$saved_CFLAGS"
    ])
 ])


AC_ARG_ENABLE([pie],
    [AS_HELP_STRING([--disable-pie],[Disable PIE/RELRO hardening])],,
    [enable_pie=yes])

AS_IF([test "$enable_pie" = "yes"],
 [
  saved_CFLAGS="$CFLAGS"
  saved_LDFLAGS="$LDFLAGS"
  saved_LIBS="$LIBS"
  CFLAGS="$CFLAGS -fPIE"
  LDFLAGS="$LDFLAGS -pie -Wl,-z,relro -Wl,-z,now"
  LIBS="$LIBS $OPUS_LIBS"
  AC_MSG_CHECKING([for PIE support])
  AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <opus/opus.h>]],
                                  [[OpusDecoder *dec = opus_decoder_create(48000, 2, 0L)]])],
    [ AC_MSG_RESULT([yes]) ],
    [ AC_MSG_RESULT([no])
      enable_pie=no
      CFLAGS="$saved_CFLAGS"
      LDFLAGS="$saved_LDFLAGS"
    ])
  LIBS="$saved_LIBS"
 ])

CFLAGS="$CFLAGS -W"

saved_CFLAGS="$CFLAGS"
CFLAGS="$CFLAGS -Wall -Wextra -Wcast-align -Wnested-externs -Wshadow -Wstrict-prototypes"
AC_MSG_CHECKING([if ${CC} supports -Wall -Wextra -Wcast-align -Wnested-externs -Wshadow -Wstrict-prototypes])
AC_COMPILE_IFELSE([AC_LANG_SOURCE([[char foo;]])],
    [ AC_MSG_RESULT([yes]) ],
    [ AC_MSG_RESULT([no])
      CFLAGS="$saved_CFLAGS"
    ])

AC_FUNC_FSEEKO

saved_LIBS="$LIBS"
LIBS="$LIBS $LIBM"
AC_CHECK_FUNCS([lrintf])
AC_CHECK_FUNCS([fminf])
AC_CHECK_FUNCS([fmaxf])
LIBS="$saved_LIBS"

AC_CONFIG_FILES([Makefile])
AC_CONFIG_HEADERS([config.h])
AC_OUTPUT

AC_MSG_NOTICE([
------------------------------------------------------------------------
  $PACKAGE_NAME $PACKAGE_VERSION:  Automatic configuration OK.

    Compiler support:

      C99 var arrays: ................ ${has_var_arrays}
      C99 lrintf: .................... ${ac_cv_func_lrintf}
      Stack protector: ............... ${enable_stack_protector}
      PIE: ........................... ${enable_pie}

    General configuration:

      Assertion checking: ............ ${enable_assertions}
      FLAC input: .................... ${with_flac}

------------------------------------------------------------------------

 Type "make; make install" to compile and install
])

