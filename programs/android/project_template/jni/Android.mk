# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := native-activity

LOCAL_SRC_FILES := main.cpp c/qbx.cpp
#LOCAL_SRC_FILES := main.c GL/glew.c tut.cpp

#FreeGlut
LOCAL_C_INCLUDES += $(LOCAL_PATH)/c/parts/core/android_core/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/c/parts/core/android_core/src




LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_callbacks.c
#LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_cursor.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_display.c
#LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_ext.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_font_data.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_gamemode.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_init.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_internal.h
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_input_devices.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_joystick.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_main.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_misc.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_overlay.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_spaceball.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_state.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_stroke_mono_roman.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_stroke_roman.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_structure.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_videoresize.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_window.c

#LOCAL_SRC_FILES += c/parts/core/android_core/src/fg_menu.c

LOCAL_SRC_FILES += c/parts/core/android_core/src/util/xparsegeometry_repl.c


#===ANDROID SPECIFIC FILES (also required)
LOCAL_SRC_FILES += c/parts/core/android_core/src/egl/fg_internal_egl.h
LOCAL_SRC_FILES += c/parts/core/android_core/src/egl/fg_display_egl.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/egl/fg_init_egl.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/egl/fg_structure_egl.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/egl/fg_window_egl.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/native_app_glue/android_native_app_glue.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/native_app_glue/android_native_app_glue.h
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_runtime_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_gamemode_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_input_devices_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_joystick_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_main_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_spaceball_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_state_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_window_android.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/opengles_stubs.c
LOCAL_SRC_FILES += c/parts/core/android_core/src/android/fg_internal_android.h



LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM
#LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv2



LOCAL_STATIC_LIBRARIES := android_native_app_glue
LOCAL_CFLAGS := -w

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
