#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   +   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='leptonica'
pkg='lept'
apt='libleptonica-dev'
dsc='An open source C library for efficient image processing and image analysis operations'
lic='copyleft'
src='https://github.com/DanBloomberg/leptonica.git'
cfg='am'
dep='zlib libjpeg libpng libwebp libtiff giflib openjpeg'
eta='180'

lst_inc='leptonica/bmf.h leptonica/bilateral.h leptonica/allheaders.h \
         leptonica/readbarcode.h leptonica/pix.h leptonica/environ.h \
         leptonica/watershed.h leptonica/rbtree.h leptonica/arrayaccess.h \
         leptonica/alltypes.h leptonica/bmfdata.h leptonica/list.h \
         leptonica/stringcode.h leptonica/hashmap.h leptonica/jbclass.h \
         leptonica/colorfill.h leptonica/sudoku.h leptonica/gplot.h \
         leptonica/heap.h leptonica/ccbord.h leptonica/leptwin.h \
         leptonica/array.h leptonica/bbuffer.h leptonica/ptra.h \
         leptonica/endianness.h leptonica/queue.h leptonica/imageio.h \
         leptonica/morph.h leptonica/dewarp.h leptonica/recog.h \
         leptonica/stack.h leptonica/bmp.h leptonica/regutils.h'
lst_lib='liblept'
lst_bin='converttops converttopdf convertsegfilestops convertfilestops \
         convertsegfilestopdf imagetops xtractprotos fileinfo \
         convertformat convertfilestopdf'
lst_oth='lib/cmake/LeptonicaConfig-version.cmake \
         lib/cmake/LeptonicaConfig.cmake'

case $cfg in
    cm|ccm|cmake|ccmake)  cbk="BUILD_PROG";;
    ac|ag|am|ar|automake) cbk="programs" mkc="distclean";;
esac

extraOpts(){
      case $1 in
            --jpeg) dep_add "libjpeg";;
            --png)  dep_add "libpng";;
            --webp) dep_add "libwebp";;
            --tiff) dep_add "libtiff";;
            --gif)  dep_add "giflib";;
            --openjpeg)  dep_add "openjpeg";;
            --min) unset dep;;
      esac
}
CFLAGS="-Wno-address-of-packed-member $CFLAGS"

. xbuilder.sh

case $arch in *mingw32|a*gnu*) dep="zlib $dep";; esac

case $build_tool in
    automake) CFG="--disable-fast-install";;
    cmake) CFG="-DSW_BUILD=OFF";;
esac

start
