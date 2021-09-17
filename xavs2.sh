#!/bin/bash
# test-ok: win64
# HEADER-----------------------------------
lib='xavs2'
dsc='An open-source encoder of AVS2-P2/IEEE1857.4 video coding standard'
lic='GPL-2.0'
src='https://github.com/pkuvcl/xavs2.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='60'
pkg='xavs2'
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
CSH="--enable-static"
CBN="--disable-cli"
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="--enable-cli"
  [[ $bbin -eq 0 ]] && CBN="--disable-cli"
fi

# HEADER-----------------------------------

case $arch in
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --sysroot=${SYSROOT} $CFG"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --sysroot=/usr/$arch $CFG"
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac
AS=nasm
# Required function buildSrc
buildSrc(){
	gitClone $src $lib
}

# Required function buildLib
buildLib(){

  pushd $SRCDIR/build/linux >/dev/null
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  log configure
  logme ./configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
  popd >/dev/null
}
start