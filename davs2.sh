#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   +   +   +   +   .   .   .   .  static
#  .   .   .   .   .   +   .   .   .   .   .  shared
#  .   .   .   .   .   +   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='davs2'
dsc='An open-source decoder of AVS2-P2/IEEE1857.4 video coding standard'
lic='GPL-2.0'
src='https://github.com/pkuvcl/davs2.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='davs2'

eta='40'
lsz=
psz=
ets=(20 0 0 40 46 69 18 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared --with-pic=1"
cs1="--enable-static --enable-shared --with-pic=1"
cb0="--disable-cli"
cb1="--enable-cli"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG=
dbld=$SRCDIR
loadToolchain
AS=nasm
CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi
case $arch in
  aarch*|arm* ) CFG="$CFG --disable-asm" CFLAGS="$CFLAGS -mfpu=neon";;
  x64_86-linux-gnu ) CFG="";;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

buildLib(){
  pushd $SRCDIR/build/linux >/dev/null
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  doLog 'configure' ./configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  doLog 'install' ${MAKE_EXECUTABLE} install
  popd >/dev/null
}
# Use function buildPC to manually build pkg-config .pc file

start