#!/bin/bash
# test-ok: win64
# HEADER-----------------------------------
lib='davs2'
dsc='An open-source decoder of AVS2-P2/IEEE1857.4 video coding standard'
lic='GPL-2.0'
src='https://github.com/pkuvcl/davs2.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='60'
pkg='davs2'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-cli"
cb1="--enable-cli"
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG=
CSH=$cs0
CBN=$cb0
dbld=$SRCDIR
# END--------------------------------------

# HEADER-----------------------------------

loadToolchain
AS=nasm
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure

# Use function buildLib to custom build
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