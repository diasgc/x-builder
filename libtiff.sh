#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libtiff'
dsc='TIFF Library and Utilities'
lic='GPL?'
src='https://gitlab.com/libtiff/libtiff.git'
sty='git'
cfg='cm'
tls=''
dep=
#dep='libzstd liblzma'
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
CSH=
CBN=
mkclean=distclean
# -----------------------------------------

extraOpts(){
    case $1 in
        --jbig) dep="libjbig $dep" CFG="-DJBIG_INCLUDE_DIR=$LIBSDIR/include -DJBIG_LIBRARY_RELEASE=$LIBSDIR/lib/libjbig.a $CFG";;
        --lzma) dep="liblzma $dep" CFG="-DLIBLZMA_INCLUDE_DIR=$LIBSDIR/include -DLIBLZMA_LIBRARY_RELEASE=$LIBSDIR/lib/liblzma.a $CFG";;
        --jpeg) dep="libjpeg $dep" CFG="-DJPEG_INCLUDE_DIR=$LIBSDIR/include -DJPEG_LIBRARY_RELEASE=$LIBSDIR/lib/libjpeg.a $CFG";;
        --jp12) dep="libjpeg $dep" CFG="-DJPEG12_INCLUDE_DIR=$LIBSDIR/include -DJPEG12_LIBRARY=$LIBSDIR/lib/libturbojpeg.a $CFG";;
        --zstd) dep="libzstd $dep" CFG="-DZSTD_INCLUDE_DIR=$LIBSDIR/include -DZSTD_LIBRARY_RELEASE=$LIBSDIR/lib/libzstd.a $CFG";;
        --webp) dep="libwebp $dep" CFG="-DWebP_INCLUDE_DIR=$LIBSDIR/include -DWebP_LIBRARY_RELEASE=$LIBSDIR/lib/libwebp.a $CFG";;
    esac
}

. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start