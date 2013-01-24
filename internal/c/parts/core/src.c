#ifdef QB64_MACOSX
 //note: MacOSX uses Apple's GLUT not FreeGLUT
 #include <OpenGL/gl.h>
 #include <OpenGL/glu.h>
 #include <OpenGL/glext.h>
 #include <GLUT/glut.h>
#else
 #define CORE_FREEGLUT
 #ifdef QB64_BACKSLASH_FILESYSTEM
  #include "src\\freeglut.h"
 #else
  #include "src/freeglut.h"
 #endif
#endif
