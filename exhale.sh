#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86
#  +   +   .   +   +   .   +   .
#
# HEADER-----------------------------------
lib='exhale'
dsc='an open-source ISO/IEC 23003-3 (USAC, xHE-AAC) encoder'
lic='Copyright'
src='https://gitlab.com/ecodis/exhale.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='exhale'
# -----------------------------------------
eta='150'
lsz=1384
psz=3936
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=

# enable main toolchain util
. tcutils.sh

dbld=$SRCDIR/build_${arch}
# requided defs
CFG="-DBUILD_TESTS=OFF"
CSH=$cs0
CBN=
# HEADER-----------------------------------

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# buildSrc(){}

# Use function patchSrc to custom patch src and/or configure
patchSrc(){
	# path-sep format for linux
  sed -i 's|\\|\/|g' $SRCDIR/src/app/exhaleApp.rc
}

# Use function buildLib to custom build
# buildLib(){}

# Use function buildPC to manually build pkg-config .pc file
# buildPC(){}

start