#!/bin/bash
# HEADER-----------------------------------
lib='libraw'
dsc='Raw image decoder library (non-thread-safe)'
lic='LGPL-2.1 CDDL'
src='https://github.com/LibRaw/LibRaw.git'
sty='git'
cfg='ac'
tls=''
dep='zlib libjpeg lcms2 jasper'
eta=''
pkg='libraw'
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
CFG="--disable-examples"
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
	doAutoreconf $SRCDIR
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  export LDFLAGS="-L${LIBSDIR}/zlib/lib -L${LIBSDIR}/libjpeg/lib"
  export CPPFLAGS="-I${LIBSDIR}/zlib/include -I${LIBSDIR}/libjpeg/include"
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start