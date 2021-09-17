#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86
#  F   F   F   F   +   .   F   .
#
# HEADER-----------------------------------
lib='codec2'
dsc='A speech codec for 2400 bit/s and below'
lic='BSD'
src='https://github.com/drowe67/codec2.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='codec2'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DUNITTEST=OFF"
cb1="-DUNITTEST=ON"
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CSH=$cs0
CBN=$cb0
dbld=$SRCDIR/build_${arch}
CFG="-DINSTALL_EXAMPLES=OFF"
# END--------------------------------------

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start