#ifndef QB64_GLES
 #include "glew/include/GL/glew.h"
#endif

#ifdef QB64_MACOSX
 //note: MacOSX uses Apple's GLUT not FreeGLUT
 #include <OpenGL/gl.h>
 #include <OpenGL/glu.h>
 #include <OpenGL/glext.h>
 #include <GLUT/glut.h>
#else
 #define CORE_FREEGLUT
 #include "src/freeglut.h"
#endif
