#!/bin/bash
# HEADER-----------------------------------
lib='libpulse'
dsc='PulseAudio Client Interface'
lic='LGPL-2.1'
src='https://gitlab.freedesktop.org/pulseaudio/pulseaudio.git'
sty='git'
cfg='ac'
tls='libtool'
dep='sndfile'
eta='60'
pkg='libpulse'
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
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------

case $arch in
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;
  x86_64-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG"
    [ -f /usr/${arch}/bin/libtool ] || installMingw64Pkg libtool http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-libtool-2.4.6-17-any.pkg.tar.zst
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
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN \
  LIBSNDFILE_CFLAGS="-I$LIBSDIR/sndfile/include" LIBSNDFILE_LIBS="-L$LIBSDIR/sndfile/lib -lsndfile"

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install

}

start