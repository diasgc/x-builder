#!/bin/bash
# test-ok: linux64 aarch64-android win64 win32 x64-android
# HEADER-----------------------------------
lib='vpx'
dsc='WebM Project VPx codec implementation'
lic='GPL?'
src='https://chromium.googlesource.com/webm/libvpx'
sty='git'
cfg='ac'
tls=''
dep=''
eta='180'
pkg='vpx'
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
CFG="--disable-docs --disable-install-srcs --disable-install-docs --disable-examples --disable-tools \
  --enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-vp9-temporal-denoising --enable-vp9-postproc \
  --enable-postproc --enable-onthefly-bitpacking --enable-multi-res-encoding --enable-better-hw-compatibility \
  --enable-webm-io --enable-libyuv --enable-experimental"
CSH="--enable-static --disable-shared --enable-pic"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --enable-pic"
fi

# HEADER-----------------------------------

case $arch in
  aarch64-linux-android ) setNDKToolchain && CFG="--target=arm64-android-gcc $CFG";;
  arm-linux-androideabi ) setNDKToolchain && CFG="--target=armv7-android-gcc $CFG";;
  i686-linux-android ) setNDKToolchain && CFG="--target=x86-android-gcc $CFG";;
  x86_64-linux-android ) setNDKToolchain && CFG="--target=x86_64-android-gcc $CFG";;
  i686-w64-mingw32 ) setMinGWToolchain && CFG="--target=x86-win32-gcc --disable-unit-tests $CFG";;
  x86_64-w64-mingw32 ) setMinGWToolchain && CFG="--target=x86_64-win64-gcc --disable-unit-tests $CFG";;
  i686-linux-gnu ) setGnuToolchain && CFG="--target=x86-linux-gcc $CFG";;
  x86_64-linux-gnu ) setGnuToolchain && CFG="--target=x86_64-linux-gcc $CFG";;
  armv7-linux-gnu ) setGnuToolchain && CFG="--target=armv7-linux-gcc $CFG";;
  aarch64-linux-gnu ) setGnuToolchain && CFG="--target=arm64-linux-gcc $CFG";;
esac
export AS=nasm

# Required function buildSrc
buildSrc(){
  gitClone $src $lib
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  #export CFLAGS="$EXTRA_CFLAGS $CFLAGS -fno-asynchronous-unwind-tables"
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  
  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start