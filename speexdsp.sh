#!/bin/bash
# HEADER-----------------------------------
lib='speexdsp'
dsc='Speexdsp is a speech processing library that goes along with the Speex codec'
lic='BSD'
src='https://github.com/xiph/speexdsp.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='91'
pkg='speexdsp'
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
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG" #CC_FOR_BUILD=cc 
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

  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  
  log clean
  logme ${MAKE_EXECUTABLE} clean
  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start