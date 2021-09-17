#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libtiff'
dsc='TIFF Library and Utilities'
lic='GPL?'
src='https://gitlab.com/libtiff/libtiff.git'
sty='git'
cfg='cm'
tls=''
dep='libzstd liblzma libjbig libjpeg'
pkg='libtiff-4'

eta='150'
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
CFG="-DJBIG_INCLUDE_DIR=$LIBSDIR/libjbig/include \
-DJBIG_LIBRARY=$LIBSDIR/libjbig/lib/libjbig.a \
-DJPEG_INCLUDE_DIR=$LIBSDIR/libjpeg/include \
-DJPEG_LIBRARY_RELEASE=$LIBSDIR/libjpeg/lib/libjpeg.a \
-DZSTD_INCLUDE_DIR=$LIBSDIR/libzstd/include \
-DZSTD_LIBRARY=$LIBSDIR/libzstf/lib/libzstd.a \
-DLIBLZMA_INCLUDE_DIR=$LIBSDIR/liblzma/include \
-DLIBLZMA_LIBRARY_RELEASE=$LIBSDIR/liblzma/lib/liblzma.a"
#-DJPEG12_INCLUDE_DIR=$LIBSDIR/libjbig/include \
#-DJPEG12_LIBRARY=$LIBSDIR/libjpeg/lib/libturbojpeg.a \
#-DWEBP_INCLUDE_DIR=$LIBSDIR/webp/include \
#-DWEBP_LIBRARY=$LIBSDIR/webp/lib/libwebp.a \
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start