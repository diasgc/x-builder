#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86
#  +   .   .   .   +   .   +   .
#
# HEADER-----------------------------------
lib='flac'
dsc='Free Lossless Audio Codec'
lic='BSD'
src='https://github.com/xiph/flac.git'
sty='git'
cfg='cm'
tls=''
dep='libogg libiconv'
pkg='flac'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_PROGRAMS=OFF"
cb1="-DBUILD_PROGRAMS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
dbld=$SRCDIR/build_${arch}
CFG="-DBUILD_CXXLIBS=ON -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF \
  -DINSTALL_MANPAGES=OFF -DWITH_ASM=ON \
  -DOGG_INCLUDE_DIR=$LIBSDIR/libogg/include -DOGG_LIBRARY=$LIBSDIR/libogg/lib/libogg.a \
  -DWITH_OGG=ON -DIconv_LIBRARY=$LIBSDIR/libiconv/lib/libiconv.a \
  -DIconv_INCLUDE_DIR=$LIBSDIR/libiconv/include"
# END--------------------------------------

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
case $arch in
	*android*) CMAKE_EXECUTABLE=cmake;;
  *mingw32 ) LD=$CC AS=nasm;;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start