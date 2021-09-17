#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
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
dep=''
pkg='libopenjp2'

eta='195'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_STATIC_LIBS=ON"
cs1="-DBUILD_SHARED_LIBS=ON"
def="$cs0"
cb0=
cb1=
CSH=
CBN=
# -----------------------------------------

. tcutils.sh

extraOpts(){
      case $1 in
            --lcms2) dep="lcms2 $dep" CFG="-DLCMS2_LIBRARY=$LIBSDIR/lib/liblcms2.a -DLCMS2_INCLUDE_DIR=$LIBSDIR/include $CFG";;
            --png)   dep="libpng $dep" CFG="-DPNG_LIBRARY_RELEASE=$LIBSDIR/lib/libpng.a -DPNG_PNG_INCLUDE_DIR=$LIBSDIR/include $CFG";;
            --tiff)  dep="libtiff $dep" CFG="-DTIFF_LIBRARY_RELEASE=$LIBSDIR/lib/libtiff.a -DTIFF_INCLUDE_DIR=$LIBSDIR/include $CFG";;
      esac
}
# Other options include:
# -DOPJ_USE_THREAD=ON: Build with thread/mutex support
# -DOPJ_DISABLE_TPSOT_FIX=OFF: Disable TPsot==TNsot fix. See https://github.com/uclouvain/openjpeg/issues/254.

dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start
