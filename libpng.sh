#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libpng'
dsc='Portable Network Graphics support'
lic=''
src='https://git.code.sf.net/p/libpng/code'
sty='git'
cfg='cm'
tls=''
dep='zlib'
pkg='libpng'

eta='192'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DPNG_SHARED=OFF -DPNG_STATIC=ON"
cs1="-DPNG_SHARED=ON -DPNG_STATIC=ON"
cb0="-DPNG_EXECUTABLES=OFF"
cb1="-DPNG_EXECUTABLES=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="-DPNG_TESTS=OFF -DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include"
# -DZLIB_INCLUDE_DIR=$(pkg-config $LIBSDIR/zlib/lib/) -DZLIB_LIBRARY=$LIBSDIR/zlib/lib/libz
# -DPNG_BUILD_ZLIB=ON -DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include -DZLIB_LIBRARY_RELEASE=$LIBSDIR/zlib/lib/libz.a
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
case $arch in 
    aarch64*|arm* ) CFG="$CFG -DPNG_ARM_NEON=off";;&
    *linux* ) CFG="$CFG -DZLIB_LIBRARY=$LIBSDIR/zlib/lib/libz.a";;
    *mingw32 ) CFG="$CFG -DZLIB_LIBRARY=$LIBSDIR/zlib/lib/libzlib.dll.a";;
esac
#setPkgConfigDir $LIBSDIR/zlib/lib/pkgconfig

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start