#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='nettle'
dsc='Nettle - a low-level cryptographic library'
lic='LGPL-3.0'
src='https://git.lysator.liu.se/nettle/nettle.git'
sty='git'
cfg='ac'
tls=''
dep='gmp'
pkg='nettle'
prp='lib64/pkgconfig/nettle.pc'

eta='40'
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
CFG="--disable-documentation --disable-mini-gmp --enable-pic"
dbld=$SRCDIR
loadToolchain
case $arch in
  i686-*|x86_64-* ) CFG="$CFG --enable-x86-sha-ni --enable-x86-aesni" ;;&
  aarch64-*|arm-*) CFG="$CFG --enable-arm-neon" ;;&
  *-android|*-androideabi ) CFG="--host=${arch} --disable-assembler $CFG";;
  *-w64-mingw32 ) CFG="CC_FOR_BUILD=gcc --host=${arch} --disable-assembler $CFG";;
  x86_64-linux-gnu ) PKGDIR=$INSTALL_DIR/lib64/pkgconfig ;;
  i686-linux-gnu ) CFG="--host=${arch} $CFG" ;;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){

  doAutoreconf $SRCDIR

  log 'clean '
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  setPkgConfigDir $PKGDIR gmp

  doLog 'configure' $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install
  
  # x86_64-linux-gnu has lib64 instead lib
  pushd $LIBSDIR/$lib >/dev/null 
  [ -d lib64 ] && [ ! -d lib ] && ln -s lib64 lib
  popd >/dev/null
}
# Use function buildPC to manually build pkg-config .pc file

start