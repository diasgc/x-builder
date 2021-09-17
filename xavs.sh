#!/bin/bash
# test-ok: win64 linux
# test-fail: android 'unrecognized machine aarch64-linux'
# HEADER-----------------------------------
lib='xavs'
dsc='High quality encoder and decoder of the Audio Video Standard of China (AVS)'
lic='GPL-2.0'
src='https://svn.code.sf.net/p/xavs/code/trunk'
sty='svn'
cfg='ac'
tls=''
dep=''
eta='30'
pkg='xavs'
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
CFG="--disable-asm --enable-pic"
CSH=
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-shared"
  [[ $bshared -eq 0 ]] && CSH=
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------
loadToolchain
case $arch in
  arm-linux*|aarch64-linux* ) CFG="--host=arm-linux-gnu $CFG" ;;
  x86_64-linux* ) CFG="--host=x86_64-linux-gnu $CFG" ;;
  i686-linux* ) CFG="--host=i686-linux-gnu $CFG" ;;
  *-w64-mingw32 ) CFG="--host=${arch} $CFG" ;;
esac

# Required function buildSrc
buildSrc(){
	log svn
  logme svn checkout $src $lib
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  log configure
  logme ./configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}
start