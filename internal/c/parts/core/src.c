#ifndef QB64_GLES
 #include "glew/include/GL/glew.h"
#endif

#ifdef QB64_ANDROID
	#include <EGL/egl.h>
	#include <GLES/gl.h>
	#include <GLES/glext.h>
#endif

#ifdef QB64_MACOSX
 //note: MacOSX uses Apple's GLUT not FreeGLUT
 #include <OpenGL/gl.h>
 #include <OpenGL/glu.h>
 #include <OpenGL/glext.h>
 #include <GLUT/glut.h>
#else
 #define CORE_FREEGLUT
 #ifdef QB64_ANDROID
  #include "android_core/include/GL/freeglut.h"
  #include "glues/src/glues.h"
 #else
  #ifdef QB64_BACKSLASH_FILESYSTEM
   #include "src\\freeglut.h"
  #else
   #include "src/freeglut.h"
  #endif
 #endif
#endif
