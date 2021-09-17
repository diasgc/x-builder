
#!/bin/bash
# HEADER-----------------------------------
lib='wavpack'
dsc='WavPack encode/decode library, command-line programs, and several plugins'
lic='BSD 3-clause'
src='https://github.com/dbry/WavPack.git'
sty='git'
cfg='ac'
tls=''
dep='libiconv'
eta='172'
pkg='wavpack'
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
CFG="--disable-tests --enable-rpath --disable-dsd --enable-legacy"
CSH="--enable-static --disable-shared --with-pic=1"
CBN="--disable-apps"
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="--enable-apps"
  [[ $bbin -eq 0 ]] && CBN="--disable-apps"
fi

# HEADER-----------------------------------

case $arch in
  *-linux-android* ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG" #CC_FOR_BUILD=cc 
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;&
  aarch64-*|arm-* ) CFG="$CFG --disable-asm";;
esac

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
	doAutoreconf $SRCDIR
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