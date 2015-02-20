void call_glAccum(uint32 a,float b){
if (!sub_gl_called) error(270);
glAccum((GLenum)a,(GLfloat)b);
}
void call_glAlphaFunc(uint32 a,float b){
if (!sub_gl_called) error(270);
glAlphaFunc((GLenum)a,(GLclampf)b);
}
uint8 call_glAreTexturesResident(int32 a,ptrszint b,ptrszint c){
if (!sub_gl_called) error(270);
return (uint8)(GLboolean)glAreTexturesResident((GLsizei)a,(GLuint*)b,(GLboolean*)c);
}
void call_glArrayElement(int32 a){
if (!sub_gl_called) error(270);
glArrayElement((GLint)a);
}
void call_glBegin(uint32 a){
if (!sub_gl_called) error(270);
glBegin((GLenum)a);
}
void call_glBindTexture(uint32 a,uint32 b){
if (!sub_gl_called) error(270);
glBindTexture((GLenum)a,(GLuint)b);
}
void call_glBitmap(int32 a,int32 b,float c,float d,float e,float f,ptrszint g){
if (!sub_gl_called) error(270);
glBitmap((GLsizei)a,(GLsizei)b,(GLfloat)c,(GLfloat)d,(GLfloat)e,(GLfloat)f,(GLubyte*)g);
}
void call_glBlendFunc(uint32 a,uint32 b){
if (!sub_gl_called) error(270);
glBlendFunc((GLenum)a,(GLenum)b);
}
void call_glCallList(uint32 a){
if (!sub_gl_called) error(270);
glCallList((GLuint)a);
}
void call_glCallLists(int32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glCallLists((GLsizei)a,(GLenum)b,(GLvoid*)c);
}
void call_glClear(uint32 a){
if (!sub_gl_called) error(270);
glClear((GLbitfield)a);
}
void call_glClearAccum(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glClearAccum((GLfloat)a,(GLfloat)b,(GLfloat)c,(GLfloat)d);
}
void call_glClearColor(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glClearColor((GLclampf)a,(GLclampf)b,(GLclampf)c,(GLclampf)d);
}
void call_glClearDepth(double a){
if (!sub_gl_called) error(270);
glClearDepth((GLclampd)a);
}
void call_glClearIndex(float a){
if (!sub_gl_called) error(270);
glClearIndex((GLfloat)a);
}
void call_glClearStencil(int32 a){
if (!sub_gl_called) error(270);
glClearStencil((GLint)a);
}
void call_glClipPlane(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glClipPlane((GLenum)a,(GLdouble*)b);
}
void call_glColor3b(int8 a,int8 b,int8 c){
if (!sub_gl_called) error(270);
glColor3b((GLbyte)a,(GLbyte)b,(GLbyte)c);
}
void call_glColor3bv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3bv((GLbyte*)a);
}
void call_glColor3d(double a,double b,double c){
if (!sub_gl_called) error(270);
glColor3d((GLdouble)a,(GLdouble)b,(GLdouble)c);
}
void call_glColor3dv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3dv((GLdouble*)a);
}
void call_glColor3f(float a,float b,float c){
if (!sub_gl_called) error(270);
glColor3f((GLfloat)a,(GLfloat)b,(GLfloat)c);
}
void call_glColor3fv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3fv((GLfloat*)a);
}
void call_glColor3i(int32 a,int32 b,int32 c){
if (!sub_gl_called) error(270);
glColor3i((GLint)a,(GLint)b,(GLint)c);
}
void call_glColor3iv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3iv((GLint*)a);
}
void call_glColor3s(int16 a,int16 b,int16 c){
if (!sub_gl_called) error(270);
glColor3s((GLshort)a,(GLshort)b,(GLshort)c);
}
void call_glColor3sv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3sv((GLshort*)a);
}
void call_glColor3ub(uint8 a,uint8 b,uint8 c){
if (!sub_gl_called) error(270);
glColor3ub((GLubyte)a,(GLubyte)b,(GLubyte)c);
}
void call_glColor3ubv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3ubv((GLubyte*)a);
}
void call_glColor3ui(uint32 a,uint32 b,uint32 c){
if (!sub_gl_called) error(270);
glColor3ui((GLuint)a,(GLuint)b,(GLuint)c);
}
void call_glColor3uiv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3uiv((GLuint*)a);
}
void call_glColor3us(uint16 a,uint16 b,uint16 c){
if (!sub_gl_called) error(270);
glColor3us((GLushort)a,(GLushort)b,(GLushort)c);
}
void call_glColor3usv(ptrszint a){
if (!sub_gl_called) error(270);
glColor3usv((GLushort*)a);
}
void call_glColor4b(int8 a,int8 b,int8 c,int8 d){
if (!sub_gl_called) error(270);
glColor4b((GLbyte)a,(GLbyte)b,(GLbyte)c,(GLbyte)d);
}
void call_glColor4bv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4bv((GLbyte*)a);
}
void call_glColor4d(double a,double b,double c,double d){
if (!sub_gl_called) error(270);
glColor4d((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d);
}
void call_glColor4dv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4dv((GLdouble*)a);
}
void call_glColor4f(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glColor4f((GLfloat)a,(GLfloat)b,(GLfloat)c,(GLfloat)d);
}
void call_glColor4fv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4fv((GLfloat*)a);
}
void call_glColor4i(int32 a,int32 b,int32 c,int32 d){
if (!sub_gl_called) error(270);
glColor4i((GLint)a,(GLint)b,(GLint)c,(GLint)d);
}
void call_glColor4iv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4iv((GLint*)a);
}
void call_glColor4s(int16 a,int16 b,int16 c,int16 d){
if (!sub_gl_called) error(270);
glColor4s((GLshort)a,(GLshort)b,(GLshort)c,(GLshort)d);
}
void call_glColor4sv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4sv((GLshort*)a);
}
void call_glColor4ub(uint8 a,uint8 b,uint8 c,uint8 d){
if (!sub_gl_called) error(270);
glColor4ub((GLubyte)a,(GLubyte)b,(GLubyte)c,(GLubyte)d);
}
void call_glColor4ubv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4ubv((GLubyte*)a);
}
void call_glColor4ui(uint32 a,uint32 b,uint32 c,uint32 d){
if (!sub_gl_called) error(270);
glColor4ui((GLuint)a,(GLuint)b,(GLuint)c,(GLuint)d);
}
void call_glColor4uiv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4uiv((GLuint*)a);
}
void call_glColor4us(uint16 a,uint16 b,uint16 c,uint16 d){
if (!sub_gl_called) error(270);
glColor4us((GLushort)a,(GLushort)b,(GLushort)c,(GLushort)d);
}
void call_glColor4usv(ptrszint a){
if (!sub_gl_called) error(270);
glColor4usv((GLushort*)a);
}
void call_glColorMask(uint8 a,uint8 b,uint8 c,uint8 d){
if (!sub_gl_called) error(270);
glColorMask((GLboolean)a,(GLboolean)b,(GLboolean)c,(GLboolean)d);
}
void call_glColorMaterial(uint32 a,uint32 b){
if (!sub_gl_called) error(270);
glColorMaterial((GLenum)a,(GLenum)b);
}
void call_glColorPointer(int32 a,uint32 b,int32 c,ptrszint d){
if (!sub_gl_called) error(270);
glColorPointer((GLint)a,(GLenum)b,(GLsizei)c,(GLvoid*)d);
}
void call_glCopyPixels(int32 a,int32 b,int32 c,int32 d,uint32 e){
if (!sub_gl_called) error(270);
glCopyPixels((GLint)a,(GLint)b,(GLsizei)c,(GLsizei)d,(GLenum)e);
}
void call_glCopyTexImage1D(uint32 a,int32 b,uint32 c,int32 d,int32 e,int32 f,int32 g){
if (!sub_gl_called) error(270);
glCopyTexImage1D((GLenum)a,(GLint)b,(GLenum)c,(GLint)d,(GLint)e,(GLsizei)f,(GLint)g);
}
void call_glCopyTexImage2D(uint32 a,int32 b,uint32 c,int32 d,int32 e,int32 f,int32 g,int32 h){
if (!sub_gl_called) error(270);
glCopyTexImage2D((GLenum)a,(GLint)b,(GLenum)c,(GLint)d,(GLint)e,(GLsizei)f,(GLsizei)g,(GLint)h);
}
void call_glCopyTexSubImage1D(uint32 a,int32 b,int32 c,int32 d,int32 e,int32 f){
if (!sub_gl_called) error(270);
glCopyTexSubImage1D((GLenum)a,(GLint)b,(GLint)c,(GLint)d,(GLint)e,(GLsizei)f);
}
void call_glCopyTexSubImage2D(uint32 a,int32 b,int32 c,int32 d,int32 e,int32 f,int32 g,int32 h){
if (!sub_gl_called) error(270);
glCopyTexSubImage2D((GLenum)a,(GLint)b,(GLint)c,(GLint)d,(GLint)e,(GLint)f,(GLsizei)g,(GLsizei)h);
}
void call_glCullFace(uint32 a){
if (!sub_gl_called) error(270);
glCullFace((GLenum)a);
}
void call_glDeleteLists(uint32 a,int32 b){
if (!sub_gl_called) error(270);
glDeleteLists((GLuint)a,(GLsizei)b);
}
void call_glDeleteTextures(int32 a,ptrszint b){
if (!sub_gl_called) error(270);
glDeleteTextures((GLsizei)a,(GLuint*)b);
}
void call_glDepthFunc(uint32 a){
if (!sub_gl_called) error(270);
glDepthFunc((GLenum)a);
}
void call_glDepthMask(uint8 a){
if (!sub_gl_called) error(270);
glDepthMask((GLboolean)a);
}
void call_glDepthRange(double a,double b){
if (!sub_gl_called) error(270);
glDepthRange((GLclampd)a,(GLclampd)b);
}
void call_glDisable(uint32 a){
if (!sub_gl_called) error(270);
glDisable((GLenum)a);
}
void call_glDisableClientState(uint32 a){
if (!sub_gl_called) error(270);
glDisableClientState((GLenum)a);
}
void call_glDrawArrays(uint32 a,int32 b,int32 c){
if (!sub_gl_called) error(270);
glDrawArrays((GLenum)a,(GLint)b,(GLsizei)c);
}
void call_glDrawBuffer(uint32 a){
if (!sub_gl_called) error(270);
glDrawBuffer((GLenum)a);
}
void call_glDrawElements(uint32 a,int32 b,uint32 c,ptrszint d){
if (!sub_gl_called) error(270);
glDrawElements((GLenum)a,(GLsizei)b,(GLenum)c,(GLvoid*)d);
}
void call_glDrawPixels(int32 a,int32 b,uint32 c,uint32 d,ptrszint e){
if (!sub_gl_called) error(270);
glDrawPixels((GLsizei)a,(GLsizei)b,(GLenum)c,(GLenum)d,(GLvoid*)e);
}
void call_glEdgeFlag(uint8 a){
if (!sub_gl_called) error(270);
glEdgeFlag((GLboolean)a);
}
void call_glEdgeFlagPointer(int32 a,ptrszint b){
if (!sub_gl_called) error(270);
glEdgeFlagPointer((GLsizei)a,(GLvoid*)b);
}
void call_glEdgeFlagv(ptrszint a){
if (!sub_gl_called) error(270);
glEdgeFlagv((GLboolean*)a);
}
void call_glEnable(uint32 a){
if (!sub_gl_called) error(270);
glEnable((GLenum)a);
}
void call_glEnableClientState(uint32 a){
if (!sub_gl_called) error(270);
glEnableClientState((GLenum)a);
}
void call_glEvalCoord1d(double a){
if (!sub_gl_called) error(270);
glEvalCoord1d((GLdouble)a);
}
void call_glEvalCoord1dv(ptrszint a){
if (!sub_gl_called) error(270);
glEvalCoord1dv((GLdouble*)a);
}
void call_glEvalCoord1f(float a){
if (!sub_gl_called) error(270);
glEvalCoord1f((GLfloat)a);
}
void call_glEvalCoord1fv(ptrszint a){
if (!sub_gl_called) error(270);
glEvalCoord1fv((GLfloat*)a);
}
void call_glEvalCoord2d(double a,double b){
if (!sub_gl_called) error(270);
glEvalCoord2d((GLdouble)a,(GLdouble)b);
}
void call_glEvalCoord2dv(ptrszint a){
if (!sub_gl_called) error(270);
glEvalCoord2dv((GLdouble*)a);
}
void call_glEvalCoord2f(float a,float b){
if (!sub_gl_called) error(270);
glEvalCoord2f((GLfloat)a,(GLfloat)b);
}
void call_glEvalCoord2fv(ptrszint a){
if (!sub_gl_called) error(270);
glEvalCoord2fv((GLfloat*)a);
}
void call_glEvalMesh1(uint32 a,int32 b,int32 c){
if (!sub_gl_called) error(270);
glEvalMesh1((GLenum)a,(GLint)b,(GLint)c);
}
void call_glEvalMesh2(uint32 a,int32 b,int32 c,int32 d,int32 e){
if (!sub_gl_called) error(270);
glEvalMesh2((GLenum)a,(GLint)b,(GLint)c,(GLint)d,(GLint)e);
}
void call_glEvalPoint1(int32 a){
if (!sub_gl_called) error(270);
glEvalPoint1((GLint)a);
}
void call_glEvalPoint2(int32 a,int32 b){
if (!sub_gl_called) error(270);
glEvalPoint2((GLint)a,(GLint)b);
}
void call_glFeedbackBuffer(int32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glFeedbackBuffer((GLsizei)a,(GLenum)b,(GLfloat*)c);
}
void call_glFogf(uint32 a,float b){
if (!sub_gl_called) error(270);
glFogf((GLenum)a,(GLfloat)b);
}
void call_glFogfv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glFogfv((GLenum)a,(GLfloat*)b);
}
void call_glFogi(uint32 a,int32 b){
if (!sub_gl_called) error(270);
glFogi((GLenum)a,(GLint)b);
}
void call_glFogiv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glFogiv((GLenum)a,(GLint*)b);
}
void call_glFrontFace(uint32 a){
if (!sub_gl_called) error(270);
glFrontFace((GLenum)a);
}
void call_glFrustum(double a,double b,double c,double d,double e,double f){
if (!sub_gl_called) error(270);
glFrustum((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d,(GLdouble)e,(GLdouble)f);
}
uint32 call_glGenLists(int32 a){
if (!sub_gl_called) error(270);
return (uint32)(GLuint)glGenLists((GLsizei)a);
}
void call_glGenTextures(int32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGenTextures((GLsizei)a,(GLuint*)b);
}
void call_glGetBooleanv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetBooleanv((GLenum)a,(GLboolean*)b);
}
void call_glGetClipPlane(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetClipPlane((GLenum)a,(GLdouble*)b);
}
void call_glGetDoublev(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetDoublev((GLenum)a,(GLdouble*)b);
}
void call_glGetFloatv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetFloatv((GLenum)a,(GLfloat*)b);
}
void call_glGetIntegerv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetIntegerv((GLenum)a,(GLint*)b);
}
void call_glGetLightfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetLightfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glGetLightiv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetLightiv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glGetMapdv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetMapdv((GLenum)a,(GLenum)b,(GLdouble*)c);
}
void call_glGetMapfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetMapfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glGetMapiv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetMapiv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glGetMaterialfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetMaterialfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glGetMaterialiv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetMaterialiv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glGetPixelMapfv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetPixelMapfv((GLenum)a,(GLfloat*)b);
}
void call_glGetPixelMapuiv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetPixelMapuiv((GLenum)a,(GLuint*)b);
}
void call_glGetPixelMapusv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetPixelMapusv((GLenum)a,(GLushort*)b);
}
void call_glGetPointerv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glGetPointerv((GLenum)a,(GLvoid**)b);
}
void call_glGetPolygonStipple(ptrszint a){
if (!sub_gl_called) error(270);
glGetPolygonStipple((GLubyte*)a);
}
ptrszint call_glGetString(uint32 a){
if (!sub_gl_called) error(270);
return (ptrszint)(GLubyte*)glGetString((GLenum)a);
}
void call_glGetTexEnvfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetTexEnvfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glGetTexEnviv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetTexEnviv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glGetTexGendv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetTexGendv((GLenum)a,(GLenum)b,(GLdouble*)c);
}
void call_glGetTexGenfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetTexGenfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glGetTexGeniv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetTexGeniv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glGetTexImage(uint32 a,int32 b,uint32 c,uint32 d,ptrszint e){
if (!sub_gl_called) error(270);
glGetTexImage((GLenum)a,(GLint)b,(GLenum)c,(GLenum)d,(GLvoid*)e);
}
void call_glGetTexLevelParameterfv(uint32 a,int32 b,uint32 c,ptrszint d){
if (!sub_gl_called) error(270);
glGetTexLevelParameterfv((GLenum)a,(GLint)b,(GLenum)c,(GLfloat*)d);
}
void call_glGetTexLevelParameteriv(uint32 a,int32 b,uint32 c,ptrszint d){
if (!sub_gl_called) error(270);
glGetTexLevelParameteriv((GLenum)a,(GLint)b,(GLenum)c,(GLint*)d);
}
void call_glGetTexParameterfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetTexParameterfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glGetTexParameteriv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glGetTexParameteriv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glHint(uint32 a,uint32 b){
if (!sub_gl_called) error(270);
glHint((GLenum)a,(GLenum)b);
}
void call_glIndexMask(uint32 a){
if (!sub_gl_called) error(270);
glIndexMask((GLuint)a);
}
void call_glIndexPointer(uint32 a,int32 b,ptrszint c){
if (!sub_gl_called) error(270);
glIndexPointer((GLenum)a,(GLsizei)b,(GLvoid*)c);
}
void call_glIndexd(double a){
if (!sub_gl_called) error(270);
glIndexd((GLdouble)a);
}
void call_glIndexdv(ptrszint a){
if (!sub_gl_called) error(270);
glIndexdv((GLdouble*)a);
}
void call_glIndexf(float a){
if (!sub_gl_called) error(270);
glIndexf((GLfloat)a);
}
void call_glIndexfv(ptrszint a){
if (!sub_gl_called) error(270);
glIndexfv((GLfloat*)a);
}
void call_glIndexi(int32 a){
if (!sub_gl_called) error(270);
glIndexi((GLint)a);
}
void call_glIndexiv(ptrszint a){
if (!sub_gl_called) error(270);
glIndexiv((GLint*)a);
}
void call_glIndexs(int16 a){
if (!sub_gl_called) error(270);
glIndexs((GLshort)a);
}
void call_glIndexsv(ptrszint a){
if (!sub_gl_called) error(270);
glIndexsv((GLshort*)a);
}
void call_glIndexub(uint8 a){
if (!sub_gl_called) error(270);
glIndexub((GLubyte)a);
}
void call_glIndexubv(ptrszint a){
if (!sub_gl_called) error(270);
glIndexubv((GLubyte*)a);
}
void call_glInterleavedArrays(uint32 a,int32 b,ptrszint c){
if (!sub_gl_called) error(270);
glInterleavedArrays((GLenum)a,(GLsizei)b,(GLvoid*)c);
}
uint8 call_glIsEnabled(uint32 a){
if (!sub_gl_called) error(270);
return (uint8)(GLboolean)glIsEnabled((GLenum)a);
}
uint8 call_glIsList(uint32 a){
if (!sub_gl_called) error(270);
return (uint8)(GLboolean)glIsList((GLuint)a);
}
uint8 call_glIsTexture(uint32 a){
if (!sub_gl_called) error(270);
return (uint8)(GLboolean)glIsTexture((GLuint)a);
}
void call_glLightModelf(uint32 a,float b){
if (!sub_gl_called) error(270);
glLightModelf((GLenum)a,(GLfloat)b);
}
void call_glLightModelfv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glLightModelfv((GLenum)a,(GLfloat*)b);
}
void call_glLightModeli(uint32 a,int32 b){
if (!sub_gl_called) error(270);
glLightModeli((GLenum)a,(GLint)b);
}
void call_glLightModeliv(uint32 a,ptrszint b){
if (!sub_gl_called) error(270);
glLightModeliv((GLenum)a,(GLint*)b);
}
void call_glLightf(uint32 a,uint32 b,float c){
if (!sub_gl_called) error(270);
glLightf((GLenum)a,(GLenum)b,(GLfloat)c);
}
void call_glLightfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glLightfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glLighti(uint32 a,uint32 b,int32 c){
if (!sub_gl_called) error(270);
glLighti((GLenum)a,(GLenum)b,(GLint)c);
}
void call_glLightiv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glLightiv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glLineStipple(int32 a,uint16 b){
if (!sub_gl_called) error(270);
glLineStipple((GLint)a,(GLushort)b);
}
void call_glLineWidth(float a){
if (!sub_gl_called) error(270);
glLineWidth((GLfloat)a);
}
void call_glListBase(uint32 a){
if (!sub_gl_called) error(270);
glListBase((GLuint)a);
}
void call_glLoadMatrixd(ptrszint a){
if (!sub_gl_called) error(270);
glLoadMatrixd((GLdouble*)a);
}
void call_glLoadMatrixf(ptrszint a){
if (!sub_gl_called) error(270);
glLoadMatrixf((GLfloat*)a);
}
void call_glLoadName(uint32 a){
if (!sub_gl_called) error(270);
glLoadName((GLuint)a);
}
void call_glLogicOp(uint32 a){
if (!sub_gl_called) error(270);
glLogicOp((GLenum)a);
}
void call_glMap1d(uint32 a,double b,double c,int32 d,int32 e,ptrszint f){
if (!sub_gl_called) error(270);
glMap1d((GLenum)a,(GLdouble)b,(GLdouble)c,(GLint)d,(GLint)e,(GLdouble*)f);
}
void call_glMap1f(uint32 a,float b,float c,int32 d,int32 e,ptrszint f){
if (!sub_gl_called) error(270);
glMap1f((GLenum)a,(GLfloat)b,(GLfloat)c,(GLint)d,(GLint)e,(GLfloat*)f);
}
void call_glMap2d(uint32 a,double b,double c,int32 d,int32 e,double f,double g,int32 h,int32 i,ptrszint j){
if (!sub_gl_called) error(270);
glMap2d((GLenum)a,(GLdouble)b,(GLdouble)c,(GLint)d,(GLint)e,(GLdouble)f,(GLdouble)g,(GLint)h,(GLint)i,(GLdouble*)j);
}
void call_glMap2f(uint32 a,float b,float c,int32 d,int32 e,float f,float g,int32 h,int32 i,ptrszint j){
if (!sub_gl_called) error(270);
glMap2f((GLenum)a,(GLfloat)b,(GLfloat)c,(GLint)d,(GLint)e,(GLfloat)f,(GLfloat)g,(GLint)h,(GLint)i,(GLfloat*)j);
}
void call_glMapGrid1d(int32 a,double b,double c){
if (!sub_gl_called) error(270);
glMapGrid1d((GLint)a,(GLdouble)b,(GLdouble)c);
}
void call_glMapGrid1f(int32 a,float b,float c){
if (!sub_gl_called) error(270);
glMapGrid1f((GLint)a,(GLfloat)b,(GLfloat)c);
}
void call_glMapGrid2d(int32 a,double b,double c,int32 d,double e,double f){
if (!sub_gl_called) error(270);
glMapGrid2d((GLint)a,(GLdouble)b,(GLdouble)c,(GLint)d,(GLdouble)e,(GLdouble)f);
}
void call_glMapGrid2f(int32 a,float b,float c,int32 d,float e,float f){
if (!sub_gl_called) error(270);
glMapGrid2f((GLint)a,(GLfloat)b,(GLfloat)c,(GLint)d,(GLfloat)e,(GLfloat)f);
}
void call_glMaterialf(uint32 a,uint32 b,float c){
if (!sub_gl_called) error(270);
glMaterialf((GLenum)a,(GLenum)b,(GLfloat)c);
}
void call_glMaterialfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glMaterialfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glMateriali(uint32 a,uint32 b,int32 c){
if (!sub_gl_called) error(270);
glMateriali((GLenum)a,(GLenum)b,(GLint)c);
}
void call_glMaterialiv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glMaterialiv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glMatrixMode(uint32 a){
if (!sub_gl_called) error(270);
glMatrixMode((GLenum)a);
}
void call_glMultMatrixd(ptrszint a){
if (!sub_gl_called) error(270);
glMultMatrixd((GLdouble*)a);
}
void call_glMultMatrixf(ptrszint a){
if (!sub_gl_called) error(270);
glMultMatrixf((GLfloat*)a);
}
void call_glNewList(uint32 a,uint32 b){
if (!sub_gl_called) error(270);
glNewList((GLuint)a,(GLenum)b);
}
void call_glNormal3b(int8 a,int8 b,int8 c){
if (!sub_gl_called) error(270);
glNormal3b((GLbyte)a,(GLbyte)b,(GLbyte)c);
}
void call_glNormal3bv(ptrszint a){
if (!sub_gl_called) error(270);
glNormal3bv((GLbyte*)a);
}
void call_glNormal3d(double a,double b,double c){
if (!sub_gl_called) error(270);
glNormal3d((GLdouble)a,(GLdouble)b,(GLdouble)c);
}
void call_glNormal3dv(ptrszint a){
if (!sub_gl_called) error(270);
glNormal3dv((GLdouble*)a);
}
void call_glNormal3f(float a,float b,float c){
if (!sub_gl_called) error(270);
glNormal3f((GLfloat)a,(GLfloat)b,(GLfloat)c);
}
void call_glNormal3fv(ptrszint a){
if (!sub_gl_called) error(270);
glNormal3fv((GLfloat*)a);
}
void call_glNormal3i(int32 a,int32 b,int32 c){
if (!sub_gl_called) error(270);
glNormal3i((GLint)a,(GLint)b,(GLint)c);
}
void call_glNormal3iv(ptrszint a){
if (!sub_gl_called) error(270);
glNormal3iv((GLint*)a);
}
void call_glNormal3s(int16 a,int16 b,int16 c){
if (!sub_gl_called) error(270);
glNormal3s((GLshort)a,(GLshort)b,(GLshort)c);
}
void call_glNormal3sv(ptrszint a){
if (!sub_gl_called) error(270);
glNormal3sv((GLshort*)a);
}
void call_glNormalPointer(uint32 a,int32 b,ptrszint c){
if (!sub_gl_called) error(270);
glNormalPointer((GLenum)a,(GLsizei)b,(GLvoid*)c);
}
void call_glOrtho(double a,double b,double c,double d,double e,double f){
if (!sub_gl_called) error(270);
glOrtho((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d,(GLdouble)e,(GLdouble)f);
}
void call_glPassThrough(float a){
if (!sub_gl_called) error(270);
glPassThrough((GLfloat)a);
}
void call_glPixelMapfv(uint32 a,int32 b,ptrszint c){
if (!sub_gl_called) error(270);
glPixelMapfv((GLenum)a,(GLsizei)b,(GLfloat*)c);
}
void call_glPixelMapuiv(uint32 a,int32 b,ptrszint c){
if (!sub_gl_called) error(270);
glPixelMapuiv((GLenum)a,(GLsizei)b,(GLuint*)c);
}
void call_glPixelMapusv(uint32 a,int32 b,ptrszint c){
if (!sub_gl_called) error(270);
glPixelMapusv((GLenum)a,(GLsizei)b,(GLushort*)c);
}
void call_glPixelStoref(uint32 a,float b){
if (!sub_gl_called) error(270);
glPixelStoref((GLenum)a,(GLfloat)b);
}
void call_glPixelStorei(uint32 a,int32 b){
if (!sub_gl_called) error(270);
glPixelStorei((GLenum)a,(GLint)b);
}
void call_glPixelTransferf(uint32 a,float b){
if (!sub_gl_called) error(270);
glPixelTransferf((GLenum)a,(GLfloat)b);
}
void call_glPixelTransferi(uint32 a,int32 b){
if (!sub_gl_called) error(270);
glPixelTransferi((GLenum)a,(GLint)b);
}
void call_glPixelZoom(float a,float b){
if (!sub_gl_called) error(270);
glPixelZoom((GLfloat)a,(GLfloat)b);
}
void call_glPointSize(float a){
if (!sub_gl_called) error(270);
glPointSize((GLfloat)a);
}
void call_glPolygonMode(uint32 a,uint32 b){
if (!sub_gl_called) error(270);
glPolygonMode((GLenum)a,(GLenum)b);
}
void call_glPolygonOffset(float a,float b){
if (!sub_gl_called) error(270);
glPolygonOffset((GLfloat)a,(GLfloat)b);
}
void call_glPolygonStipple(ptrszint a){
if (!sub_gl_called) error(270);
glPolygonStipple((GLubyte*)a);
}
void call_glPrioritizeTextures(int32 a,ptrszint b,ptrszint c){
if (!sub_gl_called) error(270);
glPrioritizeTextures((GLsizei)a,(GLuint*)b,(GLclampf*)c);
}
void call_glPushAttrib(uint32 a){
if (!sub_gl_called) error(270);
glPushAttrib((GLbitfield)a);
}
void call_glPushClientAttrib(uint32 a){
if (!sub_gl_called) error(270);
glPushClientAttrib((GLbitfield)a);
}
void call_glPushName(uint32 a){
if (!sub_gl_called) error(270);
glPushName((GLuint)a);
}
void call_glRasterPos2d(double a,double b){
if (!sub_gl_called) error(270);
glRasterPos2d((GLdouble)a,(GLdouble)b);
}
void call_glRasterPos2dv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos2dv((GLdouble*)a);
}
void call_glRasterPos2f(float a,float b){
if (!sub_gl_called) error(270);
glRasterPos2f((GLfloat)a,(GLfloat)b);
}
void call_glRasterPos2fv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos2fv((GLfloat*)a);
}
void call_glRasterPos2i(int32 a,int32 b){
if (!sub_gl_called) error(270);
glRasterPos2i((GLint)a,(GLint)b);
}
void call_glRasterPos2iv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos2iv((GLint*)a);
}
void call_glRasterPos2s(int16 a,int16 b){
if (!sub_gl_called) error(270);
glRasterPos2s((GLshort)a,(GLshort)b);
}
void call_glRasterPos2sv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos2sv((GLshort*)a);
}
void call_glRasterPos3d(double a,double b,double c){
if (!sub_gl_called) error(270);
glRasterPos3d((GLdouble)a,(GLdouble)b,(GLdouble)c);
}
void call_glRasterPos3dv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos3dv((GLdouble*)a);
}
void call_glRasterPos3f(float a,float b,float c){
if (!sub_gl_called) error(270);
glRasterPos3f((GLfloat)a,(GLfloat)b,(GLfloat)c);
}
void call_glRasterPos3fv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos3fv((GLfloat*)a);
}
void call_glRasterPos3i(int32 a,int32 b,int32 c){
if (!sub_gl_called) error(270);
glRasterPos3i((GLint)a,(GLint)b,(GLint)c);
}
void call_glRasterPos3iv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos3iv((GLint*)a);
}
void call_glRasterPos3s(int16 a,int16 b,int16 c){
if (!sub_gl_called) error(270);
glRasterPos3s((GLshort)a,(GLshort)b,(GLshort)c);
}
void call_glRasterPos3sv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos3sv((GLshort*)a);
}
void call_glRasterPos4d(double a,double b,double c,double d){
if (!sub_gl_called) error(270);
glRasterPos4d((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d);
}
void call_glRasterPos4dv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos4dv((GLdouble*)a);
}
void call_glRasterPos4f(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glRasterPos4f((GLfloat)a,(GLfloat)b,(GLfloat)c,(GLfloat)d);
}
void call_glRasterPos4fv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos4fv((GLfloat*)a);
}
void call_glRasterPos4i(int32 a,int32 b,int32 c,int32 d){
if (!sub_gl_called) error(270);
glRasterPos4i((GLint)a,(GLint)b,(GLint)c,(GLint)d);
}
void call_glRasterPos4iv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos4iv((GLint*)a);
}
void call_glRasterPos4s(int16 a,int16 b,int16 c,int16 d){
if (!sub_gl_called) error(270);
glRasterPos4s((GLshort)a,(GLshort)b,(GLshort)c,(GLshort)d);
}
void call_glRasterPos4sv(ptrszint a){
if (!sub_gl_called) error(270);
glRasterPos4sv((GLshort*)a);
}
void call_glReadBuffer(uint32 a){
if (!sub_gl_called) error(270);
glReadBuffer((GLenum)a);
}
void call_glReadPixels(int32 a,int32 b,int32 c,int32 d,uint32 e,uint32 f,ptrszint g){
if (!sub_gl_called) error(270);
glReadPixels((GLint)a,(GLint)b,(GLsizei)c,(GLsizei)d,(GLenum)e,(GLenum)f,(GLvoid*)g);
}
void call_glRectd(double a,double b,double c,double d){
if (!sub_gl_called) error(270);
glRectd((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d);
}
void call_glRectdv(ptrszint a,ptrszint b){
if (!sub_gl_called) error(270);
glRectdv((GLdouble*)a,(GLdouble*)b);
}
void call_glRectf(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glRectf((GLfloat)a,(GLfloat)b,(GLfloat)c,(GLfloat)d);
}
void call_glRectfv(ptrszint a,ptrszint b){
if (!sub_gl_called) error(270);
glRectfv((GLfloat*)a,(GLfloat*)b);
}
void call_glRecti(int32 a,int32 b,int32 c,int32 d){
if (!sub_gl_called) error(270);
glRecti((GLint)a,(GLint)b,(GLint)c,(GLint)d);
}
void call_glRectiv(ptrszint a,ptrszint b){
if (!sub_gl_called) error(270);
glRectiv((GLint*)a,(GLint*)b);
}
void call_glRects(int16 a,int16 b,int16 c,int16 d){
if (!sub_gl_called) error(270);
glRects((GLshort)a,(GLshort)b,(GLshort)c,(GLshort)d);
}
void call_glRectsv(ptrszint a,ptrszint b){
if (!sub_gl_called) error(270);
glRectsv((GLshort*)a,(GLshort*)b);
}
int32 call_glRenderMode(uint32 a){
if (!sub_gl_called) error(270);
return (int32)(GLint)glRenderMode((GLenum)a);
}
void call_glRotated(double a,double b,double c,double d){
if (!sub_gl_called) error(270);
glRotated((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d);
}
void call_glRotatef(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glRotatef((GLfloat)a,(GLfloat)b,(GLfloat)c,(GLfloat)d);
}
void call_glScaled(double a,double b,double c){
if (!sub_gl_called) error(270);
glScaled((GLdouble)a,(GLdouble)b,(GLdouble)c);
}
void call_glScalef(float a,float b,float c){
if (!sub_gl_called) error(270);
glScalef((GLfloat)a,(GLfloat)b,(GLfloat)c);
}
void call_glScissor(int32 a,int32 b,int32 c,int32 d){
if (!sub_gl_called) error(270);
glScissor((GLint)a,(GLint)b,(GLsizei)c,(GLsizei)d);
}
void call_glSelectBuffer(int32 a,ptrszint b){
if (!sub_gl_called) error(270);
glSelectBuffer((GLsizei)a,(GLuint*)b);
}
void call_glShadeModel(uint32 a){
if (!sub_gl_called) error(270);
glShadeModel((GLenum)a);
}
void call_glStencilFunc(uint32 a,int32 b,uint32 c){
if (!sub_gl_called) error(270);
glStencilFunc((GLenum)a,(GLint)b,(GLuint)c);
}
void call_glStencilMask(uint32 a){
if (!sub_gl_called) error(270);
glStencilMask((GLuint)a);
}
void call_glStencilOp(uint32 a,uint32 b,uint32 c){
if (!sub_gl_called) error(270);
glStencilOp((GLenum)a,(GLenum)b,(GLenum)c);
}
void call_glTexCoord1d(double a){
if (!sub_gl_called) error(270);
glTexCoord1d((GLdouble)a);
}
void call_glTexCoord1dv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord1dv((GLdouble*)a);
}
void call_glTexCoord1f(float a){
if (!sub_gl_called) error(270);
glTexCoord1f((GLfloat)a);
}
void call_glTexCoord1fv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord1fv((GLfloat*)a);
}
void call_glTexCoord1i(int32 a){
if (!sub_gl_called) error(270);
glTexCoord1i((GLint)a);
}
void call_glTexCoord1iv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord1iv((GLint*)a);
}
void call_glTexCoord1s(int16 a){
if (!sub_gl_called) error(270);
glTexCoord1s((GLshort)a);
}
void call_glTexCoord1sv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord1sv((GLshort*)a);
}
void call_glTexCoord2d(double a,double b){
if (!sub_gl_called) error(270);
glTexCoord2d((GLdouble)a,(GLdouble)b);
}
void call_glTexCoord2dv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord2dv((GLdouble*)a);
}
void call_glTexCoord2f(float a,float b){
if (!sub_gl_called) error(270);
glTexCoord2f((GLfloat)a,(GLfloat)b);
}
void call_glTexCoord2fv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord2fv((GLfloat*)a);
}
void call_glTexCoord2i(int32 a,int32 b){
if (!sub_gl_called) error(270);
glTexCoord2i((GLint)a,(GLint)b);
}
void call_glTexCoord2iv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord2iv((GLint*)a);
}
void call_glTexCoord2s(int16 a,int16 b){
if (!sub_gl_called) error(270);
glTexCoord2s((GLshort)a,(GLshort)b);
}
void call_glTexCoord2sv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord2sv((GLshort*)a);
}
void call_glTexCoord3d(double a,double b,double c){
if (!sub_gl_called) error(270);
glTexCoord3d((GLdouble)a,(GLdouble)b,(GLdouble)c);
}
void call_glTexCoord3dv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord3dv((GLdouble*)a);
}
void call_glTexCoord3f(float a,float b,float c){
if (!sub_gl_called) error(270);
glTexCoord3f((GLfloat)a,(GLfloat)b,(GLfloat)c);
}
void call_glTexCoord3fv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord3fv((GLfloat*)a);
}
void call_glTexCoord3i(int32 a,int32 b,int32 c){
if (!sub_gl_called) error(270);
glTexCoord3i((GLint)a,(GLint)b,(GLint)c);
}
void call_glTexCoord3iv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord3iv((GLint*)a);
}
void call_glTexCoord3s(int16 a,int16 b,int16 c){
if (!sub_gl_called) error(270);
glTexCoord3s((GLshort)a,(GLshort)b,(GLshort)c);
}
void call_glTexCoord3sv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord3sv((GLshort*)a);
}
void call_glTexCoord4d(double a,double b,double c,double d){
if (!sub_gl_called) error(270);
glTexCoord4d((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d);
}
void call_glTexCoord4dv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord4dv((GLdouble*)a);
}
void call_glTexCoord4f(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glTexCoord4f((GLfloat)a,(GLfloat)b,(GLfloat)c,(GLfloat)d);
}
void call_glTexCoord4fv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord4fv((GLfloat*)a);
}
void call_glTexCoord4i(int32 a,int32 b,int32 c,int32 d){
if (!sub_gl_called) error(270);
glTexCoord4i((GLint)a,(GLint)b,(GLint)c,(GLint)d);
}
void call_glTexCoord4iv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord4iv((GLint*)a);
}
void call_glTexCoord4s(int16 a,int16 b,int16 c,int16 d){
if (!sub_gl_called) error(270);
glTexCoord4s((GLshort)a,(GLshort)b,(GLshort)c,(GLshort)d);
}
void call_glTexCoord4sv(ptrszint a){
if (!sub_gl_called) error(270);
glTexCoord4sv((GLshort*)a);
}
void call_glTexCoordPointer(int32 a,uint32 b,int32 c,ptrszint d){
if (!sub_gl_called) error(270);
glTexCoordPointer((GLint)a,(GLenum)b,(GLsizei)c,(GLvoid*)d);
}
void call_glTexEnvf(uint32 a,uint32 b,float c){
if (!sub_gl_called) error(270);
glTexEnvf((GLenum)a,(GLenum)b,(GLfloat)c);
}
void call_glTexEnvfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glTexEnvfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glTexEnvi(uint32 a,uint32 b,int32 c){
if (!sub_gl_called) error(270);
glTexEnvi((GLenum)a,(GLenum)b,(GLint)c);
}
void call_glTexEnviv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glTexEnviv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glTexGend(uint32 a,uint32 b,double c){
if (!sub_gl_called) error(270);
glTexGend((GLenum)a,(GLenum)b,(GLdouble)c);
}
void call_glTexGendv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glTexGendv((GLenum)a,(GLenum)b,(GLdouble*)c);
}
void call_glTexGenf(uint32 a,uint32 b,float c){
if (!sub_gl_called) error(270);
glTexGenf((GLenum)a,(GLenum)b,(GLfloat)c);
}
void call_glTexGenfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glTexGenfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glTexGeni(uint32 a,uint32 b,int32 c){
if (!sub_gl_called) error(270);
glTexGeni((GLenum)a,(GLenum)b,(GLint)c);
}
void call_glTexGeniv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glTexGeniv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glTexImage1D(uint32 a,int32 b,int32 c,int32 d,int32 e,uint32 f,uint32 g,ptrszint h){
if (!sub_gl_called) error(270);
glTexImage1D((GLenum)a,(GLint)b,(GLint)c,(GLsizei)d,(GLint)e,(GLenum)f,(GLenum)g,(GLvoid*)h);
}
void call_glTexImage2D(uint32 a,int32 b,int32 c,int32 d,int32 e,int32 f,uint32 g,uint32 h,ptrszint i){
if (!sub_gl_called) error(270);
glTexImage2D((GLenum)a,(GLint)b,(GLint)c,(GLsizei)d,(GLsizei)e,(GLint)f,(GLenum)g,(GLenum)h,(GLvoid*)i);
}
void call_glTexParameterf(uint32 a,uint32 b,float c){
if (!sub_gl_called) error(270);
glTexParameterf((GLenum)a,(GLenum)b,(GLfloat)c);
}
void call_glTexParameterfv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glTexParameterfv((GLenum)a,(GLenum)b,(GLfloat*)c);
}
void call_glTexParameteri(uint32 a,uint32 b,int32 c){
if (!sub_gl_called) error(270);
glTexParameteri((GLenum)a,(GLenum)b,(GLint)c);
}
void call_glTexParameteriv(uint32 a,uint32 b,ptrszint c){
if (!sub_gl_called) error(270);
glTexParameteriv((GLenum)a,(GLenum)b,(GLint*)c);
}
void call_glTexSubImage1D(uint32 a,int32 b,int32 c,int32 d,uint32 e,uint32 f,ptrszint g){
if (!sub_gl_called) error(270);
glTexSubImage1D((GLenum)a,(GLint)b,(GLint)c,(GLsizei)d,(GLenum)e,(GLenum)f,(GLvoid*)g);
}
void call_glTexSubImage2D(uint32 a,int32 b,int32 c,int32 d,int32 e,int32 f,uint32 g,uint32 h,ptrszint i){
if (!sub_gl_called) error(270);
glTexSubImage2D((GLenum)a,(GLint)b,(GLint)c,(GLint)d,(GLsizei)e,(GLsizei)f,(GLenum)g,(GLenum)h,(GLvoid*)i);
}
void call_glTranslated(double a,double b,double c){
if (!sub_gl_called) error(270);
glTranslated((GLdouble)a,(GLdouble)b,(GLdouble)c);
}
void call_glTranslatef(float a,float b,float c){
if (!sub_gl_called) error(270);
glTranslatef((GLfloat)a,(GLfloat)b,(GLfloat)c);
}
void call_glVertex2d(double a,double b){
if (!sub_gl_called) error(270);
glVertex2d((GLdouble)a,(GLdouble)b);
}
void call_glVertex2dv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex2dv((GLdouble*)a);
}
void call_glVertex2f(float a,float b){
if (!sub_gl_called) error(270);
glVertex2f((GLfloat)a,(GLfloat)b);
}
void call_glVertex2fv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex2fv((GLfloat*)a);
}
void call_glVertex2i(int32 a,int32 b){
if (!sub_gl_called) error(270);
glVertex2i((GLint)a,(GLint)b);
}
void call_glVertex2iv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex2iv((GLint*)a);
}
void call_glVertex2s(int16 a,int16 b){
if (!sub_gl_called) error(270);
glVertex2s((GLshort)a,(GLshort)b);
}
void call_glVertex2sv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex2sv((GLshort*)a);
}
void call_glVertex3d(double a,double b,double c){
if (!sub_gl_called) error(270);
glVertex3d((GLdouble)a,(GLdouble)b,(GLdouble)c);
}
void call_glVertex3dv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex3dv((GLdouble*)a);
}
void call_glVertex3f(float a,float b,float c){
if (!sub_gl_called) error(270);
glVertex3f((GLfloat)a,(GLfloat)b,(GLfloat)c);
}
void call_glVertex3fv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex3fv((GLfloat*)a);
}
void call_glVertex3i(int32 a,int32 b,int32 c){
if (!sub_gl_called) error(270);
glVertex3i((GLint)a,(GLint)b,(GLint)c);
}
void call_glVertex3iv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex3iv((GLint*)a);
}
void call_glVertex3s(int16 a,int16 b,int16 c){
if (!sub_gl_called) error(270);
glVertex3s((GLshort)a,(GLshort)b,(GLshort)c);
}
void call_glVertex3sv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex3sv((GLshort*)a);
}
void call_glVertex4d(double a,double b,double c,double d){
if (!sub_gl_called) error(270);
glVertex4d((GLdouble)a,(GLdouble)b,(GLdouble)c,(GLdouble)d);
}
void call_glVertex4dv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex4dv((GLdouble*)a);
}
void call_glVertex4f(float a,float b,float c,float d){
if (!sub_gl_called) error(270);
glVertex4f((GLfloat)a,(GLfloat)b,(GLfloat)c,(GLfloat)d);
}
void call_glVertex4fv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex4fv((GLfloat*)a);
}
void call_glVertex4i(int32 a,int32 b,int32 c,int32 d){
if (!sub_gl_called) error(270);
glVertex4i((GLint)a,(GLint)b,(GLint)c,(GLint)d);
}
void call_glVertex4iv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex4iv((GLint*)a);
}
void call_glVertex4s(int16 a,int16 b,int16 c,int16 d){
if (!sub_gl_called) error(270);
glVertex4s((GLshort)a,(GLshort)b,(GLshort)c,(GLshort)d);
}
void call_glVertex4sv(ptrszint a){
if (!sub_gl_called) error(270);
glVertex4sv((GLshort*)a);
}
void call_glVertexPointer(int32 a,uint32 b,int32 c,ptrszint d){
if (!sub_gl_called) error(270);
glVertexPointer((GLint)a,(GLenum)b,(GLsizei)c,(GLvoid*)d);
}
void call_glViewport(int32 a,int32 b,int32 c,int32 d){
if (!sub_gl_called) error(270);
glViewport((GLint)a,(GLint)b,(GLsizei)c,(GLsizei)d);
}

