#!/bin/bash
# HEADER-----------------------------------
lib='nettle'
dsc='Nettle - a low-level cryptographic library'
lic='LGPL-3.0'
src='https://git.lysator.liu.se/nettle/nettle.git'
sty='git'
cfg='ac'
tls=''
dep='gmp'
eta='40'
pkg='nettle'
prp='lib64/pkgconfig/nettle.pc'

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
CFG="--disable-documentation --disable-mini-gmp"
CSH="--enable-static --disable-shared --enable-pic"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --enable-pic"
fi

# HEADER-----------------------------------

case $arch in
  i686-*|x86_64-* ) CFG="--enable-x86-sha-ni --enable-x86-aesni $CFG" ;;&
  aarch64-*|arm-*) CFG="--enable-arm-neon $CFG" ;;&
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --disable-assembler $CFG";;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="CC_FOR_BUILD=gcc --host=${arch} --disable-assembler $CFG";;
  x86_64-linux-gnu ) setGnuToolchain
    PKGDIR=$INSTALL_DIR/lib64/pkgconfig ;;
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG" ;;
esac

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
}

# Required function buildLib
buildLib(){

  doAutoreconf $SRCDIR

  log 'clean '
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  setPkgConfigDir $PKGDIR gmp

  doLog 'configure' $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  doLog 'install' ${MAKE_EXECUTABLE} install
  
  # x86_64-linux-gnu has lib64 instead lib
  pushd $LIBSDIR/$lib >/dev/null 
  [ -d lib64 ] && [ ! -d lib ] && ln -s lib64 lib
  popd >/dev/null
}

start