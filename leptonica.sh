#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='leptonica'
dsc='An open source C library for efficient image processing and image analysis operations'
lic='copyleft'
src='https://github.com/DanBloomberg/leptonica.git'
sty='git'
cfg='ag'
tls=''
dep=''
pkg='lept'

eta='120'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

mkclean="distclean"
CSH=
CBN=
# -----------------------------------------

. tcutils.sh
extraOpts(){
      case $1 in
            --jpeg) dep="libjpeg $dep" CFG="-DJPEG_LIBRARY=$LIBSDIR/lib -DJPEG_INCLUDE_DIR=$LIBSDIR/include $CFG";;
            --png)  dep="libpng $dep" CFG="-DPNG_LIBRARY_RELEASE=$LIBSDIR/lib/libpng.a -DPNG_PNG_INCLUDE_DIR=$LIBSDIR/include $CFG";;
            --webp) dep="libwebp $dep" CFG="-DWEBPMUX_LIBRARY=$LIBSDIR/lib -DWEBPMUX_INCLUDE_DIR=$LIBSDIR/include $CFG";;
            --tiff) dep="libtiff $dep" CFG="-DTIFF_LIBRARY_RELEASE=$LIBSDIR/lib/libtiff.a -DTIFF_INCLUDE_DIR=$LIBSDIR/include $CFG";;
            --gif)  dep="giflib $dep" CFG="-DGIF_LIBRARY=$LIBSDIR/lib -DGIF_INCLUDE_DIR=$LIBSDIR/include $CFG";;
      esac
}

loadToolchain
case $cfg in
    cm|ccm)
        cs0=
        cs1="-DBUILD_SHARED_LIBS=ON"
        cb0="-DBUILD_PROG=OFF"
        cb1="-DBUILD_PROG=ON"
        dbld=$SRCDIR/build_${arch}
        CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
        ;;
    ac|ar|ag)
        cs0="--enable-static"
        cs1="--enable-shared"
        cb0="--disable-programs"
        cb1="--enable-programs"
        CFG="--without-libopenjpeg --without-giflib --disable-fast-install"
        dbld=$SRCDIR
        test $arch != x86_64-linux-gnu && CFG="--host=${arch} $CFG"
        ;;
esac

# set defaults
[ -z "$CSH" ] && CSH=$cs0
[ -z "$CBN" ] && CBN=$cb0

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start