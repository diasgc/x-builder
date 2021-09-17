#!/bin/bash
# HEADER-----------------------------------
lib='shine'
dsc='Super fast fixed-point MP3 encoder'
lic='GPL-2.0'
src='https://github.com/toots/shine.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='51'
pkg='shine'

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

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} --with-pic=1"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="CC_FOR_BUILD=cc --host=${arch} --with-sysroot=/usr/$arch "
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    CFG=
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch}"
    ;;
esac

# Required function buildSrc
buildSrc(){
  gitClone $src $lib
  log bootstrap
  pushd $SRCDIR >/dev/null
  logme ./bootstrap
  popd >/dev/null
}

# Required function buildLib
buildLib(){

  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start