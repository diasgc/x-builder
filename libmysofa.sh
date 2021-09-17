#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libmysofa'
dsc='Reader for AES SOFA files to get better HRTFs'
lic='BSD'
src='https://github.com/hoene/libmysofa.git'
sty='git'
cfg='cm'
tls=''
dep='libcunit'
pkg='libmysofa'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="-DCUNIT_LIBRARY=$LIBSDIR/libcunit/lib/libcunit.a -DCUNIT_INCLUDE_DIR=$LIBSDIR/libcunit/include -DBUILD_TESTS=OFF"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
[[ $arch = *mingw32 ]] && dep="$dep zlib" CFG="$CFG -DZLIB_LIBRARY=$LIBSDIR/lib/libzlib.dll.a -DZLIB_INCLUDE_DIR=$LIBSDIR/include"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start