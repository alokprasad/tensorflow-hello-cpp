This repo is used to Compile Static tensorflow Library (libtensorflow-core.a) and Test Applocation to test both on Android and Linux 
Platform

## Download Source Code

git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout r1.13


## Building for Linux

tensorflow/contrib/makefile/download_dependencies.sh
sudo apt-get install autoconf automake libtool curl make g++ unzip zlib1g-dev \
git python

tensorflow/contrib/makefile/build_all_linux.sh


## Building for Android

* Download Android ndk (tested on  ndk r19) or 14b ??

```
export NDK_ROOT=/absolute/path/to/NDK/android-ndk-rxxx/
tensorflow/contrib/makefile/download_dependencies.sh
tensorflow/contrib/makefile/compile_android_protobuf.sh -c -a arm64-v8a
export HOST_NSYNC_LIB=`tensorflow/contrib/makefile/compile_nsync.sh`
export TARGET_NSYNC_LIB=`CC_PREFIX="${CC_PREFIX}" NDK_ROOT="${NDK_ROOT}" \
	tensorflow/contrib/makefile/compile_nsync.sh -t android -a arm64-v8a`
export ANDROID_TYPES="-D__ANDROID_TYPES_FULL__"
make -f tensorflow/contrib/makefile/Makefile TARGET=ANDROID ANDROID_ARCH=arm64-v8a ANDROID_TYPES="-D__ANDROID_TYPES_FULL__" 

All compiled libraries are in gen/lib/*
NB: ANDROID_TYPES_FULL didnt worked for me so edited platform.h and remove IS_MOBILE_PLATFORM
```
 



## Test 

To train the model run following this will create a model file in model/test_model.pb
'''
python train_model.py 
'''

Now you can either use Makefile or CMakeLists.txt to compile src/hello-tf-inference 
that loads this model and runs the graph with inputs

'''
make
or
cd build && cmake .. && make
'''

to run the application
cd build
./hello-tf_inference 


## ldd hello-tf-inference dyanmic build
	linux-vdso.so.1 (0x00007ffdcd3c9000)
	libtensorflow_cc.so => /media/alok/ws/experiments/tensorflow-1.13.1/bazel-bin/tensorflow/libtensorflow_cc.so (0x00007f5988c9a000)
	libtensorflow_framework.so => /media/alok/ws/experiments/tensorflow-1.13.1/bazel-bin/tensorflow/libtensorflow_framework.so (0x00007f5987cee000)
	libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f5987965000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f598774d000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f598735c000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f5987158000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f5986f39000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f5986b9b000)
	librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f5986993000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f5993980000)

## ldd hello-tf-inference static build
   	linux-vdso.so.1 (0x00007ffd91f8e000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f8d9026a000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f8d90066000)
	libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f8d8fcdd000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f8d8f93f000)
	libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f8d8f727000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f8d8f336000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f8d969f6000)
  
## Reference 

https://ce39906.github.io/2018/09/11/Tensorflow-%E7%BC%96%E8%AF%91%E5%8F%8A%E5%BA%94%E7%94%A8C-%E9%9D%99%E6%80%81%E5%BA%93/

