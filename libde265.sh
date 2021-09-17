#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   +   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libde265'
dsc='Open h.265 video codec implementation.'
lic='LGPL-3.0'
src='https://github.com/strukturag/libde265.git'
sty='git'
cfg='ag'
tls=''
dep=''
pkg='libde265'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static"
cs1="--enable-shared"
cb0=
cb1=
CSH=
CBN=
# -----------------------------------------

. tcutils.sh
CFG=
#"--disable-encoder"
dbld=$SRCDIR

loadToolchain --posix

if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  CSH=
  CBN=
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
  [[ $arch != x86* ]] && CFG="$CFG -DDISABLE_SSE=ON -DSUPPORTS_SSE4_1=OFF"
else
  [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
  case $arch in
    aarch64-*|arm-*) CFG="--host=${arch} --with-sysroot=${SYSROOT} --with-pic --disable-sse --disable-arm $CFG";;
    x86_64-linux-gnu);;
    *) CFG="--host=${arch} --with-sysroot=${SYSROOT} --with-pic=1 $CFG";;
  esac
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start