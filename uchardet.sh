#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='uchardet'
dsc='an encoding detector library'
lic='GPL-2'
src='https://gitlab.freedesktop.org/uchardet/uchardet.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg=''

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
cs0=
cs1=
cb0=
cb1=
# -----------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_BINARY=OFF"
cb1="-DBUILD_BINARY=ON"
CSH=$cs0
CBN=$cb1

# enable main toolchain util
. tcutils.sh

CFG="-DUSE_OMP=OFF"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
case $arch in
  aarch64*|arm* ) CFG="$CFG -DCHECK_SSE2=OFF";;
  i686*|x86_64* ) CFG="$CFG -DCHECK_SSE2=ON";;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start