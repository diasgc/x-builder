#!/bin/bash
# HEADER-----------------------------------
lib='expat'
dsc='Fast streaming XML parser written in C'
lic=''
src='https://github.com/libexpat/libexpat.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='expat'
lsz=336
# STATS------------------------------------
eta='77'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DEXPAT_BUILD_TOOLS=OFF"
cb1="-DEXPAT_BUILD_TOOLS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
dbld=$SRCDIR/build_${arch}
CFG="-DEXPAT_BUILD_EXAMPLES=OFF -DEXPAT_BUILD_TESTS=OFF"
# END--------------------------------------

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start