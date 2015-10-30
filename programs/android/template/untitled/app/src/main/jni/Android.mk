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


#<QB64_PARTS_BUILD>


include $(CLEAR_VARS)

OPENAL_DIR := c/parts/audio/out/android/OpenAL

AL_SOURCES := \
  $(OPENAL_DIR)/Alc/android.c              \
  $(OPENAL_DIR)/OpenAL32/alAuxEffectSlot.c \
  $(OPENAL_DIR)/OpenAL32/alBuffer.c        \
  $(OPENAL_DIR)/OpenAL32/alDatabuffer.c    \
  $(OPENAL_DIR)/OpenAL32/alEffect.c        \
  $(OPENAL_DIR)/OpenAL32/alError.c         \
  $(OPENAL_DIR)/OpenAL32/alExtension.c     \
  $(OPENAL_DIR)/OpenAL32/alFilter.c        \
  $(OPENAL_DIR)/OpenAL32/alListener.c      \
  $(OPENAL_DIR)/OpenAL32/alSource.c        \
  $(OPENAL_DIR)/OpenAL32/alState.c         \
  $(OPENAL_DIR)/OpenAL32/alThunk.c         \
  $(OPENAL_DIR)/Alc/ALc.c                  \
  $(OPENAL_DIR)/Alc/alcConfig.c            \
  $(OPENAL_DIR)/Alc/alcEcho.c              \
  $(OPENAL_DIR)/Alc/alcModulator.c         \
  $(OPENAL_DIR)/Alc/alcReverb.c            \
  $(OPENAL_DIR)/Alc/alcRing.c              \
  $(OPENAL_DIR)/Alc/alcThread.c            \
  $(OPENAL_DIR)/Alc/ALu.c                  \
  $(OPENAL_DIR)/Alc/bs2b.c                 \
  $(OPENAL_DIR)/Alc/null.c                 \
  $(OPENAL_DIR)/Alc/panning.c              \
  $(OPENAL_DIR)/Alc/mixer.c                \
  $(OPENAL_DIR)/Alc/audiotrack.c           \
  $(OPENAL_DIR)/Alc/opensles.c


LOCAL_MODULE    := parts_audio_out
LOCAL_SRC_FILES := $(AL_SOURCES)

LOCAL_C_INCLUDES := \
  $(HOME)/src/openal-soft/jni/OpenAL \
  $(HOME)/src/openal-soft/jni/OpenAL/include \
  $(HOME)/src/openal-soft/jni/OpenAL/OpenAL32/Include \
  c/parts/audio/out/android/OpenAL/OpenAL32/Include

LOCAL_CFLAGS += \
  -DAL_ALEXT_PROTOTYPES \

MAX_SOURCES_LOW ?= 4
MAX_SOURCES_START ?= 8
MAX_SOURCES_HIGH ?= 64

LOCAL_CFLAGS += -DMAX_SOURCES_LOW=$(MAX_SOURCES_LOW) -DMAX_SOURCES_START=$(MAX_SOURCES_START) -DMAX_SOURCES_HIGH=$(MAX_SOURCES_HIGH)
LOCAL_CFLAGS += -DPOST_FROYO

include $(BUILD_STATIC_LIBRARY)

# PARTS/AUDIO/CONVERSION
include $(CLEAR_VARS)
LOCAL_MODULE := parts_audio_conversion
LOCAL_SRC_FILES := c/parts/audio/conversion/src/resample.c
#LOCAL_CFLAGS :=
#LOCAL_C_INCLUDES :=
include $(BUILD_STATIC_LIBRARY)
#include $(PREBUILT_STATIC_LIBRARY)

# PARTS/AUDIO/DECODE/MP3
include $(CLEAR_VARS)
LOCAL_MODULE := parts_audio_decode_mp3
LOCAL_SRC_FILES := c/parts/audio/decode/mp3_mini/src/minimp3.c
#LOCAL_CFLAGS :=
#LOCAL_C_INCLUDES :=
include $(BUILD_STATIC_LIBRARY)
#include $(PREBUILT_STATIC_LIBRARY)

# PARTS/AUDIO/DECODE/OGG
include $(CLEAR_VARS)
LOCAL_MODULE := parts_audio_decode_ogg
LOCAL_SRC_FILES := c/parts/audio/decode/ogg/src/stb_vorbis.c
#LOCAL_CFLAGS :=
#LOCAL_C_INCLUDES :=
include $(BUILD_STATIC_LIBRARY)
#include $(PREBUILT_STATIC_LIBRARY)

# PARTS/VIDEO/FONT/TTF
include $(CLEAR_VARS)
LOCAL_MODULE := parts_video_font_ttf
LOCAL_SRC_FILES := c/parts/video/font/ttf/src/freetypeamalgam.c
#LOCAL_CFLAGS :=
#LOCAL_C_INCLUDES :=
include $(BUILD_STATIC_LIBRARY)
#include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)



LOCAL_MODULE    := native-activity

LOCAL_SRC_FILES := main.cpp c/qbx.cpp
#LOCAL_SRC_FILES := main.c GL/glew.c tut.cpp

#GLU ES
LOCAL_C_INCLUDES += $(LOCAL_PATH)/c/parts/core/glues/src
LOCAL_SRC_FILES += c/parts/core/glues/src/glues_error.c
LOCAL_SRC_FILES += c/parts/core/glues/src/glues_mipmap.c
LOCAL_SRC_FILES += c/parts/core/glues/src/glues_project.c
LOCAL_SRC_FILES += c/parts/core/glues/src/glues_quad.c
LOCAL_SRC_FILES += c/parts/core/glues/src/glues_registry.c
#(libtess folder not added, probably not required)

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



LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM -lOpenSLES


#LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv2



LOCAL_STATIC_LIBRARIES := android_native_app_glue
LOCAL_CFLAGS := -w

#<QB64_PARTS_REFERENCE>
LOCAL_STATIC_LIBRARIES += parts_video_font_ttf
LOCAL_STATIC_LIBRARIES += parts_audio_out
LOCAL_STATIC_LIBRARIES += parts_audio_conversion
LOCAL_STATIC_LIBRARIES += parts_audio_decode_mp3
LOCAL_STATIC_LIBRARIES += parts_audio_decode_ogg
include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
