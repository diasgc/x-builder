#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86 V1.6.38
#  +   +   +   +   .   +   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libpng'
dsc='Portable Network Graphics support'
lic='As Is'
src='https://git.code.sf.net/p/libpng/code'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='libpng'

eta='9'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DPNG_STATIC=ON"
cs1="-DPNG_SHARED=ON"
cb0="-DPNG_EXECUTABLES=OFF"
cb1="-DPNG_EXECUTABLES=ON"
CSH=
CBN=
# -----------------------------------------

. tcutils.sh
CFG="-DPNG_TESTS=OFF -DPNG_HARDWARE_OPTIMIZATIONS=OFF -DHAVE_LD_VERSION_SCRIPT=OFF"
# -DZLIB_INCLUDE_DIR=$LIBSDIR/include
# -DZLIB_INCLUDE_DIR=$(pkg-config $LIBSDIR/lib/) -DZLIB_LIBRARY=$LIBSDIR/lib/libz
# -DPNG_BUILD_ZLIB=ON -DZLIB_INCLUDE_DIR=$LIBSDIR/include -DZLIB_LIBRARY_RELEASE=$LIBSDIR/lib/libz.a
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
case $arch in 
    #aarch64*|arm* ) CFG="$CFG -DPNG_ARM_NEON=OFF";;
    #*linux* ) CFG="$CFG -DZLIB_LIBRARY=$LIBSDIR/lib/libz.a";;
    *mingw32 ) CFG="$CFG -DZLIB_LIBRARY=$LIBSDIR/lib/libzlib.dll.a" dep='zlib';;
esac
#setPkgConfigDir $LIBSDIR/zlib/lib/pkgconfig

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start