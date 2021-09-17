#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libtiff'
dsc='TIFF Library and Utilities'
lic='GPL?'
src='https://gitlab.com/libtiff/libtiff.git'
sty='git'
cfg='cm'
pkg='libtiff-4'
eta='150'
mkc=distclean
cmake_path='lib/cmake/tiff'

extraOpts(){
    case $1 in
        --jbig) dep_add 'libjbig';;
        --lzma) dep_add 'liblzma';;
        --jpeg|--jp12) dep_add 'libjpeg';;
        --zstd) dep_add 'libzstd';;
        --webp) dep_add 'libwebp';;
        --all) dep_add libjbig liblzma libjpeg libzstd libwebp;;
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
