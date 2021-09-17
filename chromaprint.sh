#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO--------------------------------
lib='chromaprint'
dsc='C library for generating audio fingerprints used by AcoustID'
lic='LGPL-2.1'
src='https://github.com/acoustid/chromaprint.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='libchromaprint'

eta='12'
lsz=
psz=
ets=(8 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_TOOLS=OFF"
cb1="-DBUILD_TOOLS=ON"
CSH=
CBN=
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DKISSFFT_SOURCE_DIR=$SRCDIR/vendor/kissfft"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start