#static Makefile, Please prefer to use CMakelists.txt version instead of Makefile

TARGET_NAME := hello-tf-inference
TF_DIR := /media/alok/ws/experiments/tensorflow-android/tensorflow
TENSORFLOW_MAKEFILE_DIR := $(TF_DIR)/tensorflow/contrib/makefile

 INCLUDES := \
-I $(TF_DIR) \
-I $(TF_DIR)/tensorflow/contrib/makefile/gen/proto \
-I $(TF_DIR)/tensorflow/contrib/makefile/gen/protobuf_android/$(ARCH)/include \
-I $(TF_DIR)/tensorflow/contrib/makefile/downloads/eigen \
-I $(TF_DIR)/tensorflow/contrib/makefile/downloads/absl \
-I $(TF_DIR)/tensorflow/contrib/makefile/downloads/nsync/public \
-I $(TF_DIR)/tensorflow/contrib/makefile/gen/protobuf/include

NSYNC_LIB := \
$(TENSORFLOW_MAKEFILE_DIR)/downloads/nsync/builds/default.linux.c++11/nsync.a

PROTOBUF_LIB := \
$(TENSORFLOW_MAKEFILE_DIR)/gen/protobuf/lib/libprotobuf.a

TENSORFLOW_CORE_LIB := \
-Wl,--whole-archive $(TF_DIR)/tensorflow/contrib/makefile/gen/lib/libtensorflow-core.a -Wl,--no-whole-archive

LIBS := \
$(TENSORFLOW_CORE_LIB) \
$(NSYNC_LIB) \
$(PROTOBUF_LIB) \
-lpthread \
-ldl

SOURCES := \
src/hello-tf-inference.cc

$(TARGET_NAME):
	 g++ -std=c++11 $(SOURCES) $(INCLUDES) -o build/$(TARGET_NAME) $(LIBS)

clean:
	 rm -rf $(TARGET_NAME)
