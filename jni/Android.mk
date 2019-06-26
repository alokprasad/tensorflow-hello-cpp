include $(CLEAR_VARS)
LOCAL_PATH := $(call my-dir)
TF_DIR := /data/alok/tensorflow-android
LOCAL_CLAGS := -std=c++11  -llog -fno-rtti  -Wall -Wc++11-extensions# whatever g++ flags you like
LOCAL_CPPFLAGS := -std=c++11  -llog -fno-rtti  -Wall -Wc++11-extensions# whatever g++ flags you like
LOCAL_LDLIBS := -L/data/alok/tensorflow-android/target/android-ndk-r15/sysroot/usr/lib -llog -fPIE -pie # whatever ld flags you like
#LIB := $(ANDROID_NDK_ROOT)/platforms/android-$(NDK_PLATFORM_VER)/arch-arm/usr/lib
LIB := /data/alok/tensorflow-android/target/android-ndk-r15/platforms/android-26/arch-arm64/usr/lib
#LIBCRT := $(LIB)/crtbegin_dynamic.o
LOCAL_MODULE := tensorflow-core
LOCAL_SRC_FILES := /data/alok/tensorflow-android/target/tensorflow/tensorflow/contrib/makefile/gen/lib/android_arm64-v8a/libtensorflow-core.a
include $(PREBUILT_STATIC_LIBRARY)

#include $(CLEAR_VARS)
LOCAL_MODULE := nsync
LOCAL_SRC_FILES := /data/alok/tensorflow-android/target/tensorflow/tensorflow/contrib/makefile/downloads/nsync/builds/arm64-v8a.android.c++11/libnsync.a
include $(PREBUILT_STATIC_LIBRARY)

LOCAL_MODULE := protobuf
LOCAL_SRC_FILES := /data/alok/tensorflow-android/target/tensorflow/tensorflow/contrib/makefile/gen/protobuf_android/arm64-v8a/lib/libprotobuf.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := hello-tf
LOCAL_CFLAGS   += -DANDROID26
APP_OPTIM := debug
LOCAL_SRC_FILES :=  src/hello-tf-inference.cc
LOCAL_WHOLE_STATIC_LIBRARIES := tensorflow-core
LOCAL_STATIC_LIBRARIES := nsync protobuf
LOCAL_C_INCLUDES := /data/alok/tensorflow-android/target/tensorflow \
/data/alok/tensorflow-android/target/tensorflow/tensorflow/contrib/makefile/gen/proto \
/data/alok/tensorflow-android/target/tensorflow/tensorflow/contrib/makefile/gen/protobuf_android/arm64-v8a/include \
$(TF_DIR)/target/tensorflow/tensorflow/contrib/makefile/downloads/eigen \
$(TF_DIR)/target/tensorflow/tensorflow/contrib/makefile/downloads/absl \
$(TF_DIR)/target/tensorflow/tensorflow/contrib/makefile/downloads/nsync/public
LOCAL_LDFLAGS := -rpath /data/local -llog

include $(BUILD_EXECUTABLE)



