#!/bin/bash
# HEADER-----------------------------------
lib='json-c'
dsc='Description: A JSON implementation in C'
lic='MIT'
src='https://github.com/json-c/json-c.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='80'
pkg='json-c'

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
CSH="-DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF -DDISABLE_STATIC_FPIC=ON"
#-DBUILD_TESTING=OFF
CBN=""
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=ON -DDISABLE_STATIC_FPIC=OFF"
  [[ $bshared -eq 0 ]] && CSH="-DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF -DDISABLE_STATIC_FPIC=ON"
fi

# CMAKE OPTIONS
# CMAKE_INSTALL_PREFIX	String	The install location.
# CMAKE_BUILD_TYPE	String	Defaults to "debug".
# BUILD_SHARED_LIBS	Bool	The default build generates a dynamic (dll/so) library. Set this to OFF to create a static library only.
# BUILD_STATIC_LIBS	Bool	The default build generates a static (lib/a) library. Set this to OFF to create a shared library only.
# DISABLE_STATIC_FPIC	Bool	The default builds position independent code. Set this to OFF to create a shared library only.
# DISABLE_BSYMBOLIC	Bool	Disable use of -Bsymbolic-functions.
# DISABLE_THREAD_LOCAL_STORAGE	Bool	Disable use of Thread-Local Storage (HAVE___THREAD).
# DISABLE_WERROR	Bool	Disable use of -Werror.
# ENABLE_RDRAND	Bool	Enable RDRAND Hardware RNG Hash Seed.
# ENABLE_THREADING	Bool	Enable partial threading support.

# HEADER-----------------------------------

case $arch in
	*-linux-android ) setNDKToolchain
    CFG="-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	  -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API $CGF"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    CFG="-DCMAKE_SYSTEM_NAME=Windows $CFG"
    ;;&
  *-linux-gnu ) setGnuToolchain
    CFG="-DCMAKE_SYSTEM_NAME=Windows $CFG"
    ;;&
  aarch64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=aarch64 $CFG";;
	arm-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=armv7a $CFG";;
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