#!/bin/bash
# test-ok: win64
# HEADER-----------------------------------
lib='leptonica'
dsc='An open source C library for efficient image processing and image analysis operations'
lic='copyleft'
src='https://github.com/DanBloomberg/leptonica.git'
sty='git'
cfg='ac'
tls=''
dep='zlib libpng libjpeg libtiff libwebp'
eta='120'
pkg='leptonica'
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
CFG="--without-libopenjpeg --without-giflib"
CSH="--enable-static --disable-shared --with-pic=1"
CBN="--disable-programs"
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="--enable-programs"
  [[ $bbin -eq 0 ]] && CBN="--disable-programs"
fi

# HEADER-----------------------------------

case $arch in
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch --without-zlib $CFG"
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
  mv $PKGDIR/lept.pc $PKGDIR/leptonica.pc
}
start