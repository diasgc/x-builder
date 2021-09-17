#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   +   .   .   .   .   .   .  shared
#  f   .   .   .   f   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='flif'
dsc='Free Lossless Image Format'
lic='BSD-2c'
src='https://github.com/FLIF-hub/FLIF.git'
sty='git'
cfg='cm'
tls=''
dep='libpng'
pkg='flif'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

cs0="-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON"
cs1="-DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=OFF"
cb0=
cb1=
CSH=$cs1
CBN=$cb0
# -----------------------------------------


. tcutils.sh
dbld=$SRCDIR/build_${arch}
SRCDIR=$SRCDIR/src
loadToolchain
CFG="-DPNG_LIBRARY=$LIBSDIR/lib/libpng.a -DPNG_PNG_INCLUDE_DIR=$LIBSDIR/include"
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
#export CXXFLAGS="-I$LIBSDIR/libpng/include -I$dbld"
export CPPFLAGS="-I$LIBSDIR/include" \
  LDFLAGS="-L$dbld -L$LIBSDIR/lib" \
  LIBS="-lpng -lz -lm" \
  PKG_CONFIG_PATH=$LIBSDIR/lib/pkgconfig

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start