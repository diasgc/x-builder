#!/bin/bash
# HEADER-----------------------------------
lib='kvazaar'
dsc='An open source C library for efficient image processing and image analysis operations'
lic='LGPL-2.1'
src='https://github.com/ultravideo/kvazaar.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='70'
pkg='kvazaar'
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
CSH="--enable-static --disable-shared --with-pic=1"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------

case $arch in
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    # patch for librt in android builds
    lrt="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${arch}/librt.a"
	  [ ! -f $lrt ] && $AR cr $lrt
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG"
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
  doAutogen $SRCDIR
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  
  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}
start