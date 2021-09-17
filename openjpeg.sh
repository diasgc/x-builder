#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='openjpeg'
dsc='OpenJPEG is an open-source JPEG 2000 codec written in C language'
lic='BSD 2-clause'
src='https://github.com/uclouvain/openjpeg.git'
sty='git'
cfg='cm'
tls=''
dep='lcms2 libpng zlib libtiff'
pkg='libopenjp2'

eta='195'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON"
cs1="-DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG=CFG="-DBUILD_JPWL=OFF -DBUILD_JPIP=ON -DBUILD_JP3D=ON -DBUILD_JAVA=OFF \
      -DLCMS2_LIBRARY=$LIBSDIR/lcms2/lib/liblcms2.a -DLCMS2_INCLUDE_DIR=$LIBSDIR/lcms2/include \
      -DPNG_LIBRARY_RELEASE=$LIBSDIR/libpng/lib/libpng.a -DPNG_PNG_INCLUDE_DIR=$LIBSDIR/libpng/include \
      -DTIFF_LIBRARY_RELEASE=$LIBSDIR/libtiff/lib/libtiff.a -DTIFF_INCLUDE_DIR=$LIBSDIR/libtiff/include \
      -DZLIB_LIBRARY_RELEASE=$LIBSDIR/zlib/lib/libz.a -DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start
