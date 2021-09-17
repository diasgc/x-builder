#!/bin/bash
# test-ok: linux win64
# HEADER-----------------------------------
lib='openssl'
dsc='TLS/SSL and crypto library'
lic='Apache-2.0'
src='https://github.com/openssl/openssl.git'
sty='git'
cfg='TODO'
tls='nasm perl'
dep=''
eta='780'
pkg='openssl'
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
CSH="-static no-shared"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-static shared"
  [[ $bshared -eq 0 ]] && CSH="-static no-shared pic"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------

case $arch in
  x86_64-linux-gnu )      setGnuToolchain   ;;
  i686-linux-gnu )        setGnuToolchain   && CFG=;;
  x86_64-w64-mingw32 )    CFG="no-idea no-mdc2 no-rc5 mingw64 --cross-compile-prefix=x86_64-w64-mingw32-";;
  i686-w64-mingw32 )      CFG="no-idea no-mdc2 no-rc5 mingw --cross-compile-prefix=i686-w64-mingw32-";;
  aarch64-linux-android ) setNDKToolchain   && CFG="android-arm64 -D__ANDROID_API__=$API";;
  arm-linux-androideabi ) setNDKToolchain   && CFG="android-arm -D__ANDROID_API__=$API";;
  i686-linux-android )    setNDKToolchain   && CFG="android-x86 -D__ANDROID_API__=$API";;
  x86_64-linux-android )  setNDKToolchain   && CFG="android-x86_64 -D__ANDROID_API__=$API";;
esac
export AS=nasm
export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME
# Required function buildSrc
buildSrc(){
	gitClone $src $lib
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  log configure
  logme $SRCDIR/Configure --prefix=${INSTALL_DIR} $CSH $CBN $CFG

  log make
  ${MAKE_EXECUTABLE} depend >> $LOGFILE 2>&1
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install_sw
}
start