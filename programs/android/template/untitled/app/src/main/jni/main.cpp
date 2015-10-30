#include <jni.h>
#include <android/log.h>

#include <android/asset_manager.h>
#include <android/asset_manager_jni.h>

#include <android/native_window.h>
#include <android_native_app_glue.h>


#define LOGI(...) ((void)__android_log_print(ANDROID_LOG_INFO, "FreeGLUT", __VA_ARGS__))

/*
#include <EGL/egl.h>
#include <GLES/gl.h>
#include <GLES/glext.h>
*/
#include "c/libqb.cpp"
 