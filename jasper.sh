#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   .   .   .   .   .  static
#  +   .   .   .   .   +   .   .   .   .   .  shared
#  +   .   .   .   .   +   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='jasper'
dsc='Image Processing/Coding Tool Kit'
lic=''
src='https://github.com/mdadams/jasper.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta=''
pkg='jasper'

eta='26'
lsz=
psz=
ets=(30 0 15 0 26 18 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DJAS_ENABLE_SHARED=OFF"
cs1="-DJAS_ENABLE_SHARED=ON"
cb0="-DJAS_ENABLE_PROGRAMS=OFF"
cb1="-DJAS_ENABLE_PROGRAMS=ON"
CSH=$cs0
CBN=$cb0
CFG="-DBUILD_TESTING=OFF -DJAS_ENABLE_DOC=OFF"
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
[[ $arch = *mingw32 ]] && CFG="$CFG -DWITH_STACK_PROTECTOR=OFF"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start