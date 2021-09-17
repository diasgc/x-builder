#!/bin/bash
# HEADER-----------------------------------
lib='opus'
dsc='Opus is a codec for interactive speech and audio transmission over the Internet'
lic='BSD'
src='https://github.com/xiph/opus.git'
sty='git'
cfg='ac'
tls=''
dep='libogg'
eta='208'
pkg='opus'
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
CFG="--disable-doc"
CSH="--enable-static --disable-shared --with-pic=1"
CBN="--disable-extra-programs"
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="--enable-extra-programs"
  [[ $bbin -eq 0 ]] && CBN="--disable-extra-programs"
fi

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
	AS=$YASM
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

  #log 'clean '
  #${MAKE_EXECUTABLE} clean >/dev/null 2>&1

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