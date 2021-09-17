#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='x265'
dsc='x265 is an open source HEVC encoder'
lic='GPL-2.0'
src='https://github.com/videolan/x265.git'
sty='git'
cfg='cm'
tls='yasm libnuma-dev'
dep=''
pkg='x265'

eta='720'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DENABLE_SHARED=OFF"
cs1="-DENABLE_SHARED=ON"
cb0="-DENABLE_CLI=OFF"
cb1="-DENABLE_CLI=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG=
#-DHIGH_BIT_DEPTH=ON
dbld=$SRCDIR/build_${arch}
SRCDIR=$SRCDIR/source
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG" AS=$YASM
case $arch in
  mingw32* ) CFG="$CFG -DENABLE_LUMA=OFF";;
  aarch64*|arm* ) CFG="$CFG -DCROSS_COMPILE_ARM=ON -DENABLE_ASSEMBLY=OFF";;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start