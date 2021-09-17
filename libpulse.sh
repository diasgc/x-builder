#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libpulse'
dsc='PulseAudio Client Interface'
lic='LGPL-2.1'
src='https://gitlab.freedesktop.org/pulseaudio/pulseaudio.git'
sty='git'
cfg='ar'
tls='libtool'
dep='sndfile'
pkg='libpulse'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
case $arch in
  *mingw32 ) CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    [ -f /usr/${arch}/bin/libtool ] || \
    installMingw64Pkg libtool \
    http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-libtool-2.4.6-17-any.pkg.tar.zst
    ;;
  $BUILD_TRIP ) ;;
  * ) CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG";;
esac
export LIBSNDFILE_CFLAGS="-I$LIBSDIR/sndfile/include" LIBSNDFILE_LIBS="-L$LIBSDIR/sndfile/lib -lsndfile"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start