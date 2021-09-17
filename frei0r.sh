#!/bin/bash
# todo: try cmake...
# HEADER-----------------------------------
lib='frei0r'
dsc='A large collection of free and portable video plugins'
lic='GPL-2.0'
src='https://github.com/dyne/frei0r.git'
sty='git'
cfg='ac'
tls=''
dep=''
xdp='gavl opencv libcairo'
pkg='frei0r'
# STATS------------------------------------
eta='275'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="--with-pic=1"
dbld=$SRCDIR
# END--------------------------------------

loadToolchain
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
else
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    doAutogen $SRCDIR
}

start