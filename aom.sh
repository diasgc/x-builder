#!/bin/bash
# HEADER-----------------------------------
lib='aom'
dsc='Alliance for Open Media AV1 codec'
lic='BSD 2-clause'
src='https://aomedia.googlesource.com/aom'
sty='git'
cfg='cm'
tls='perl'
dep=''
pkg='aom'
# STATS------------------------------------
eta='424'
lsz=10800
psz=
# FLAGS------------------------------------
cs0="-DCONFIG_SHARED=0 -DCONFIG_PIC=1"
cs1="-DCONFIG_SHARED=1"
cb0=
cb1=
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="-DENABLE_TESTS=0 -DENABLE_EXAMPLES=OFF -DENABLE_DOCS=OFF"
CSH=$cs0
CBN=
dbld=$SRCDIR/build_${arch}
# END--------------------------------------

loadToolchain
case $arch in
  aarch64-linux-android ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/arm64-android-clang.cmake \
    -DAOM_ANDROID_NDK_PATH=$ANDROID_NDK_HOME $CFG";;
  arm-linux-android* ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/arm-android-clang.cmake \
    -DAOM_ANDROID_NDK_PATH=$ANDROID_NDK_HOME $CFG";;
  i686-linux-android ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/x86-android-clang.cmake \
    -DAOM_ANDROID_NDK_PATH=$ANDROID_NDK_HOME $CFG";;
  x86_64-linux-android ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/x86_64-android-clang.cmake \
    -DAOM_ANDROID_NDK_PATH=$ANDROID_NDK_HOME $CFG";;
  i686-linux-gnu ) CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM -DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/x86-linux.cmake $CFG";;
  i686-w64-mingw32 ) CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM -DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/x86-mingw-gcc.cmake $CFG";;
  x86_64-w64-mingw32 ) CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM -DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/x86_64-mingw-gcc.cmake $CFG";;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  # create other arm-clang toolchains
  pushd $SRCDIR/build/cmake/toolchains >/dev/null

  # arm-android toolchain
  cp arm64-android-clang.cmake arm-android-clang.cmake 
  sed -i 's/arm64-v8a/armv7/g' arm-android-clang.cmake
  sed -i 's/ARM64/ARM/g' arm-android-clang.cmake
  sed -i 's/AOM_NEON_INTRIN_FLAG ""/AOM_NEON_INTRIN_FLAG "-mfpu=neon"/g' arm-android-clang.cmake

  # x86-android toolchain
  cp arm64-android-clang.cmake x86-android-clang.cmake
  sed -i 's/arm64-v8a/x86/g' x86-android-clang.cmake
  sed -i 's/ARM64/X86/g' x86-android-clang.cmake
  sed -i 's/set(AS_EXECUTABLE as)//g' x86-android-clang.cmake
  sed -i 's/set(AOM_NEON_INTRIN_FLAG "")//g' x86-android-clang.cmake
  sed -i 's/set(CONFIG_RUNTIME_CPU_DETECT 0 CACHE STRING "")//g' x86-android-clang.cmake

  # x86_86-android toolchain
  cp x86-android-clang.cmake x86_64-android-clang.cmake
  sed -i 's/x86/x86_64/g' x86_64-android-clang.cmake
  sed -i 's/X86/X86_64/g' x86_64-android-clang.cmake
  popd >/dev/null
}

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start