#!/bin/bash
# HEADER-----------------------------------
lib='vvc'
dsc='VVC VTM reference software'
lic='LGPL-2.1'
src='https://vcgit.hhi.fraunhofer.de/jvet/VVCSoftware_VTM.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='480'
pkg='vvc'

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
CFG=
CSH=
CBN=
MKF="-j${HOST_NPROC} all"
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DBUILD_SHARED_LIBS=ON"
  [[ $bshared -eq 0 ]] && CSH="-DBUILD_SHARED_LIBS=OFF"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="-DBUILD_TOOLS=ON"
  [[ $bbin -eq 0 ]] && CBN="-DBUILD_TOOLS=OFF"
fi

# HEADER-----------------------------------

case $arch in
	aarch64-linux-android ) setNDKToolchain
    CFG="-DCMAKE_SYSTEM_PROCESSOR=aarch64 -DCMAKE_SYSTEM_NAME=Android \
    -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API -DUSE_OPENCV_TOOLCHAIN_FLAGS=ON"
    #CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/CMakeBuild/cmake/toolchains/aarch64-linux-gnu-gcc-ubuntu1804.cmake"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    # mind CMAKE_FIND_ROOT_PATH /usr/share/mingw-w64 /usr/x86_64-w64-mingw32 /usr/lib/gcc/x86_64-w64-mingw32/5.3-posix
    # todo: make static build as x265 to include libstdc++-6.dll libgcc_s_seh-1.dll
    CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/CMakeBuild/cmake/toolchains/$arch-gcc-posix-ubuntu1604.cmake"
    MKF="$MKF toolset=gcc"
    ;;&
  *-linux-gnu ) setGnuToolchain;;&
  i686-linux-gnu ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/CMakeBuild/cmake/toolchains/$arch-gcc-posix-ubuntu1604.cmake";;  
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

  log all
  logme ${MAKE_EXECUTABLE} all

}

start