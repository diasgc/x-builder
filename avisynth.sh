#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   F   o   .   .   .   .  static
#  F   .   .   .   .   F   +   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# ndk issue with std::filesystem
# cannot build static libs
# PKGINFO--------------------------------
lib='avisynth'
dsc='A powerful nonlinear scripting language for video'
lic='GPL'
src='https://github.com/AviSynth/AviSynthPlus.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='avisynth'

eta=240
lsz=6150
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
# -----------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DENABLE_PLUGINS=OFF"
cb1="-DENABLE_PLUGINS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain --posix --ndkLpthread
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}${posix}.cmake -DHEADERS_ONLY=OFF -Wno-dev"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start