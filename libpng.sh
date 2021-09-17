#!/bin/bash
# HEADER-----------------------------------
lib='libpng'
dsc='Portable Network Graphics support'
lic=''
src='https://git.code.sf.net/p/libpng/code'
sty='git'
cfg='ac'
tls=''
dep='zlib'
eta='192'
pkg='libpng'
# -----------------------------------------

# required extraopts
extraOpts(){
  case $1 in
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG="-DPNG_TESTS=OFF -DPNG_BUILD_ZLIB=ON -DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include \
    -DZLIB_LIBRARY_RELEASE=$LIBSDIR/zlib/lib/libz.a"
CSH="-DPNG_SHARED=OFF -DPNG_STATIC=ON"
CBN="-DPNG_EXECUTABLES=OFF"
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DPNG_SHARED=ON -DPNG_STATIC=ON"
  [[ $bshared -eq 0 ]] && CSH="-DPNG_SHARED=OFF -DPNG_STATIC=ON"
fi

# HEADER-----------------------------------

case $arch in
	*-linux-android|*-linux-androideabi ) setNDKToolchain
    CFG="-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	  -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API $CGF"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_RC_COMPILER=${arch}-windres -DCMAKE_CMAKE_RANLIB=${arch}-ranlib \
    $CMAKE_ROOTPATH_OPTS $CFG"
    ;;&
  *-linux-gnu ) setGnuToolchain
    ;;&
  aarch64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=aarch64 -DPNG_ARM_NEON=off $CFG";;
	arm-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=armv7a -DPNG_ARM_NEON=off $CFG";;
	i686-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=x86 $CFG";;
	x86_64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=x86_64 $CFG";;
esac

# Required function buildSrc
buildSrc(){
  gitClone $src $lib
}

# Required function buildLib
buildLib(){

  log cmake
  logme ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release $CFG $CSH $CBN

  # allow advanced config with ccmake if --advanced option selected
  [ $advcfg ] && inlineCcmake $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start