#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO--------------------------------
lib='axmldec'
dsc='Stand-alone binary AndroidManifest.xml decode'
lic='ISC'
src='https://github.com/ytsutano/axmldec.git'
sty='git'
cfg='cm'
tls='libboost-all-dev'
dep=''
pkg='axmldec'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
# -----------------------------------------
cb0="-DENABLE_PLUGINS=OFF"
cb1="-DENABLE_PLUGINS=ON"
CSH=
CBN=
# -----------------------------------------

. tcutils.sh

dbld=$SRCDIR/build_${arch}
loadToolchain --posix --ndkLpthread

CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}${posix}.cmake"
# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start