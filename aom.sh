#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   +   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

# HEADER --------------------------------
lib='aom'
apt='libaom0'
dsc='Alliance for Open Media AV1 codec'
lic='BSD 2-clause'
src='https://aomedia.googlesource.com/aom'
sty='git'
cfg='cm'
tls='perl'
eta='200'
cb0="-DENABLE_EXAMPLES=OFF"
cb1="-DENABLE_EXAMPLES=ON"
cbk='ENABLE_EXAMPLES'

# LOADER --------------------------------
. xbuilder.sh

CFG="-DENABLE_TESTS=OFF -DENABLE_TOOLS=OFF -DENABLE_TESTDATA=OFF -DENABLE_DOCS=OFF -DCONFIG_PIC=1"
cmake_toolchain_file="${SRCDIR}/build/cmake/toolchains/${arch}.cmake"
[[ $arch = *android* ]] && CFG="$CFG -DAOM_ANDROID_NDK_PATH=${ANDROID_NDK_HOME}"

source_patch(){
  
  # setup toolchains
  pushdir $SRCDIR/build/cmake/toolchains
  # android API min 24 for NDK r23+
  sed -i 's/android-[0-9]\+/android-24/g' arm64-android-clang.cmake
  ln arm64-android-clang.cmake aarch64-linux-android.cmake
  # arm-android toolchain
  cp arm64-android-clang.cmake arm-linux-androideabi.cmake
  sed -i 's/arm64-v8a/armeabi-v7a/g' arm-linux-androideabi.cmake
  sed -i 's/ARM64/ARM/g' arm-linux-androideabi.cmake
  sed -i 's/AOM_NEON_INTRIN_FLAG ""/AOM_NEON_INTRIN_FLAG "-mfpu=neon"/g' arm-linux-androideabi.cmake

  # x86-android toolchain
  cp arm64-android-clang.cmake i686-linux-android.cmake
  sed -i 's/arm64-v8a/x86/g' i686-linux-android.cmake
  sed -i 's/ARM64/X86/g' i686-linux-android.cmake
  sed -i 's/set(AS_EXECUTABLE as)//g' i686-linux-android.cmake
  sed -i 's/set(AOM_NEON_INTRIN_FLAG "")//g' i686-linux-android.cmake
  sed -i 's/set(CONFIG_RUNTIME_CPU_DETECT 0 CACHE STRING "")//g' i686-linux-android.cmake

  # x86_86-android toolchain
  cp i686-linux-android.cmake x86_64-linux-android.cmake
  sed -i 's/x86/x86_64/g' x86_64-linux-android.cmake
  sed -i 's/X86/X86_64/g' x86_64-linux-android.cmake

  # x86_86-linux toolchain
  cp x86-linux.cmake x86_64-linux-gnu.cmake
  sed -i 's/x86/x86_64/g' x86_64-linux-gnu.cmake
  sed -i 's/X86/X86_64/g' x86_64-linux-gnu.cmake
  sed -i 's/-m32//g' x86_64-linux-gnu.cmake

  ln arm64-linux-gcc.cmake aarch64-linux-gnu.cmake
  ln armv7-linux-gcc.cmake arm-linux-gnueabihf.cmake
  ln x86-linux.cmake i686-linux-gnu.cmake
  
  ln arm64-mingw-gcc.cmake aarch64-w64-mingw32.cmake
  ln x86-mingw-gcc.cmake i686-w64-mingw32.cmake
  ln x86_64-mingw-gcc.cmake x86_64-w64-mingw32.cmake
  
  popdir
}

start

# Filelist
# --------

# include/aom/aom_decoder.h
# include/aom/aom_integer.h
# include/aom/aom_external_partition.h
# include/aom/aom_frame_buffer.h
# include/aom/aom_image.h
# include/aom/aom.h
# include/aom/aom_encoder.h
# include/aom/aomcx.h
# include/aom/aom_codec.h
# include/aom/aomdx.h
# lib/libaom.a
# lib/pkgconfig/aom.pc
# lib/libaom.so
# bin/aomdec
# bin/aomenc