
#!/bin/bash
# HEADER-----------------------------------
lib='x264'
dsc='x264, the best and fastest H.264 encoder'
lic='GPL-2.0'
src='https://code.videolan.org/videolan/x264.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='270'
pkg='x264'
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
CSH="--enable-static --enable-pic"
CBN="--disable-cli"
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --enable-pic"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="--enable-cli"
  [[ $bbin -eq 0 ]] && CBN="--disable-cli"
fi

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="--host=${arch} --sysroot=${SYSROOT} $CFG"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --sysroot=/usr/$arch $CFG" #CC_FOR_BUILD=cc 
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
  aarch64-*|arm-* ) CFG="--disable-asm $CFG"
    ;;
esac
export AS=nasm
# Required function buildSrc
buildSrc(){
	gitClone $src $lib
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