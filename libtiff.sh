#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  P   P   .   .   +   +   .   .   .   .   .  static
#  P   P   +   +   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

lib='libtiff'
apt="${lib}-dev"
dsc='TIFF Library and Utilities'
vrs='v4.3.0'
lic='GPL?'
src='https://gitlab.com/libtiff/libtiff.git'
cfg='cmake'
pkg='libtiff-4'
eta='150'
mkc='distclean'
mki='install/strip'
dep='liblzma libjpeg libzstd libwebp libdeflate lerc'
CFG="-Dlzma=ON -Djpeg=ON -Dzstd=ON -Dwebp=ON -Dlerc=ON -Dlibdeflate=ON"
mingw_posix=true

extraOpts(){
    case $1 in
        --min) unset dep CFG;;
    esac
}

. xbuilder.sh

build_install(){
	#no html
	sed -i '/html\/cmake_install\.cmake/d' $BUILD_DIR/cmake_install.cmake
    #no man
    sed -i '/man\/cmake_install\.cmake/d' $BUILD_DIR/cmake_install.cmake
    pushd $BUILD_DIR
    $MAKE_EXECUTABLE install
    popdir
}

start

# Filelist
# --------

# include/tiffconf.h
# include/tiffvers.h
# include/tiff.h
# include/tiffio.hxx
# include/tiffio.h
# lib/libtiffxx.so.5.7.0
# lib/pkgconfig/libtiff-4.pc
# lib/libtiff.so.5.7.0
# lib/cmake/tiff/TiffTargets-release.cmake
# lib/cmake/tiff/TiffTargets.cmake
# bin/tiffmedian
# bin/tiffset
# bin/fax2ps
# bin/tiff2bw
# bin/tiffdither
# bin/raw2tiff
# bin/tiffsplit
# bin/tiff2pdf
# bin/fax2tiff
# bin/tiff2rgba
# bin/pal2rgb
# bin/tiff2ps
# bin/tiffcrop
# bin/tiffcmp
# bin/tiffinfo
# bin/tiffcp
# bin/tiffdump
# bin/ppm2tiff