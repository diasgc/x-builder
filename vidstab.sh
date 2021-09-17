#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   +   +   +   +   .   .   .   .  static
#  +   .   .   +   +   +   +   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='vidstab'
dsc='Vidstab is a video stabilization library which can be plugged-in with Ffmpeg and Transcode'
lic='GPL-2+'
src='https://github.com/georgmartius/vid.stab.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='vidstab'

eta='80'
lsz=
psz=
ets=(0 0 0 0 5 0 0 0 0 0 0)
ls0=(0 0 0 0 128 0 0 0 0 0 0)
ls1=(0 0 0 0 108 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="-DUSE_OMP=OFF"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
case $arch in
  # aarch64*|arm* ) CFG="$CFG -DSSE2_FOUND=OFF -DSSE3_FOUND=OFF -DSSE4_1_FOUND=OFF -DSSSE3_FOUND=OFF";;
  # i686*|x86_64* ) CFG="$CFG -DSSE2_FOUND=ON -DSSE3_FOUND=ON -DSSE4_1_FOUND=ON -DSSSE3_FOUND=ON";;
  aarch64*|arm* ) CFG="$CFG -DSSE2_FOUND=OFF";;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start