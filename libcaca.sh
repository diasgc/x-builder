#!/bin/bash
# test-ok: linux64
# test-fail: win64
# HEADER-----------------------------------
lib='libcaca'
dsc='Colour AsCii Art library'
lic='GPL'
src='https://github.com/cacalabs/libcaca.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='80'
pkg='libcaca'
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
CFG="--disable-doc --disable-imlib2 --disable-cppunit --disable-slang --disable-x11 --disable-gl \
  --disable-cocoa --disable-csharp --disable-java --disable-ruby --disable-zzuf --disable-python \
  --disable-cxx"
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
    CFG="--host=${arch} --with-sysroot=/usr/$arch --enable-win32 $CFG" #CC_FOR_BUILD=cc 
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
  log bootstrap
	pushd $SRCDIR >/dev/null
  logme ./bootstrap
  popd >/dev/null
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
  mv $PKGDIR/caca.pc $PKGDIR/pkg.pc >/dev/null 2>&1
}



start