#include <jni.h>
#include <android/log.h>
#define LOGI(...) ((void)__android_log_print(ANDROID_LOG_INFO, "FreeGLUT", __VA_ARGS__))

#include <EGL/egl.h>
#include <GLES/gl.h>
#include <GLES/glext.h>

#include "c/libqb.cpp"
