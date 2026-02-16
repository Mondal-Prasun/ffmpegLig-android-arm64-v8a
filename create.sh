#!/bin/bash

# 1. Update this path to YOUR NDK root
NDK_PATH="/root/android-ndk-r29"
HOST_TAG="linux-x86_64"  # Use "darwin-x86_64" for macOS
API=29

# 2. Architectures to build
ABI="arm64-v8a"
ARCH="aarch64"
TARGET="aarch64-linux-android"

# 3. Toolchain Paths
TOOLCHAIN=$NDK_PATH/toolchains/llvm/prebuilt/$HOST_TAG
CC=$TOOLCHAIN/bin/${TARGET}${API}-clang
CXX=$TOOLCHAIN/bin/${TARGET}${API}-clang++
SYSROOT=$TOOLCHAIN/sysroot
PREFIX=$(pwd)/android/$ABI
STRIP=$TOOLCHAIN/bin/llvm-strip


# 4. The Configure Command
./configure \
    --prefix=$PREFIX \
    --target-os=android \
    --arch=$ARCH \
    --cpu=armv8-a \
    --cc=$CC \
    --cxx=$CXX \
    --strip=$STRIP \
    --sysroot=$SYSROOT \
    --enable-cross-compile \
    --enable-shared \
    --disable-static \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-avdevice \
    --disable-symver \
    --extra-cflags="-fPIC -I$SYSROOT/usr/include" \
    --extra-ldflags="-L$SYSROOT/usr/lib/$TARGET/$API -lc -lm -ldl -llog"

# 5. Build
make clean
make -j$(nproc)
make install


