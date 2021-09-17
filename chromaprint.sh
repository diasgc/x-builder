#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86 (static/shared)
#  +   .   .   .   +   .   +   .
#
# HEADER-----------------------------------
lib='chromaprint'
dsc='C library for generating audio fingerprints used by AcoustID'
lic='LGPL-2.1'
src='https://github.com/acoustid/chromaprint.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='libchromaprint'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_TOOLS=OFF"
cb1="-DBUILD_TOOLS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="-DKISSFFT_SOURCE_DIR=$SRCDIR/kissfft -DFFT_LIB=kissfft"
dbld=$SRCDIR/build_${arch}
# END--------------------------------------

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  pushd $SRCDIR >/dev/null
  doLog 'kissfft' git clone https://github.com/mborgerding/kissfft.git
  popd >/dev/null
}

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start