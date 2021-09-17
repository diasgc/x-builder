#!/bin/bash
# test-ok: linux aarch64-android
# test-fail: win64
# HEADER-----------------------------------
lib='lensfun'
dsc='An open source database of photographic lenses and their characteristics'
lic='LGPL-3.0'
src='https://github.com/lensfun/lensfun.git'
sty='git'
cfg='cm'
tls='libglib2.0-dev'
dep=''
eta='60'
pkg='lensfun'

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
CFG="-DBUILD_TESTS=OFF -DBUILD_DOC=OFF -DINSTALL_HELPER_SCRIPTS=OFF -DINSTALL_PYTHON_MODULE=OFF"
CSH="-DBUILD_STATIC=ON"
CBN=
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DBUILD_STATIC=OFF"
  [[ $bshared -eq 0 ]] && CSH="-DBUILD_STATIC=ON"
fi
#if [[ $bbin ]];then
#  [[ $bbin -eq 1 ]] && CBN=
#  [[ $bbin -eq 0 ]] && CBN=
#fi

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	  -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API $CGF"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_RC_COMPILER=${arch}-windres -DCMAKE_CMAKE_RANLIB=${arch}-ranlib -DCMAKE_ASM_YASM_COMPILER=$YASM \
    $CMAKE_ROOTPATH_OPTS $CFG"
    ;;&
  *-linux-gnu ) setGnuToolchain
    ;;&
  aarch64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=aarch64 -DCROSS_COMPILE_ARM=ON $CFG";;
  arm-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=armv7a -DCROSS_COMPILE_ARM=ON $CFG";;
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
  [ $advcfg ] && inlineCcmake $SRCDIR

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start