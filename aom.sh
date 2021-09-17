#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   +   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin
# 
# PKGINFO--------------------------------
lib='aom'
dsc='Alliance for Open Media AV1 codec'
lic='BSD 2-clause'
src='https://aomedia.googlesource.com/aom'
tag='d1d1226af626a61f7ca664b270dd473b92228984'
rep="https://aomedia.googlesource.com/aom/+archive/${tag}.tar.gz"
sty='git'
cfg='cm'
tls='perl'
dep=''
pkg='aom'

eta='125'
ets=(115 93 105 218 198 264 157 0 0 0 0)
lsz=10800
lsz_st=(52236 24316 27164 70748 9500 11144 6200 0 0 0 0)
lsz_sh=(21328 0 0 0 0 0 0 0 0 0 0)
psz=

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DENABLE_EXAMPLES=OFF"
cb1="-DENABLE_EXAMPLES=ON"
CSH=
CBN=
# --------------------------------

. tcutils.sh

CFG="-DENABLE_TESTS=0 -DENABLE_DOCS=OFF -DCONFIG_PIC=1"
dbld=$SRCDIR/build_${arch}

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/build/cmake/toolchains/${arch}.cmake $CFG"
[[ $arch = *android* ]] && CFG="$CFG -DAOM_ANDROID_NDK_PATH=$ANDROID_NDK_HOME"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

patchSrc(){
  
  # setup toolchains
  pushd $SRCDIR/build/cmake/toolchains >/dev/null

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
  
  popd >/dev/null
}

start