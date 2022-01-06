#!/bin/bash

lib='tesseract'
apt='libtesseract-dev'
dsc='An OCR Engine that was developed at HP Labs between 1985 and 1995... and now at Google'
lic='Apache-2.0'
src='https://github.com/tesseract-ocr/tesseract.git'
cfg='ag'
dep='leptonica'
pkg='tesseract'
mingw_posix=true

. xbuilder.sh

case $build_tool in
  cmake)  CFG="-DBUILD_TRAINING_TOOLS=OFF -DGRAPHICS_DISABLED=ON -DCOMPILER_SUPPORTS_MARCH_NATIVE=OFF"
          case $arch in
            *mingw32) CFG+=" -DSW_BUILD=OFF";;
            *) CFG+=" -DOPENMP_BUILD=ON -DENABLE_LTO=ON";;
          esac
          ;;
  automake) CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-debug \
    --disable-graphics \
    --disable-tessdata-prefix \
    --disable-largefile"
    mki="install-strip"
    eta='510'
    [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
    ;;
esac

start

# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU +++  .   .   .  gcc
# WIN  F   .   .   .  clang/gcc

# Filelist
# --------
# include/tesseract/ltrresultiterator.h
# include/tesseract/ocrclass.h
# include/tesseract/capi.h
# include/tesseract/unichar.h
# include/tesseract/renderer.h
# include/tesseract/export.h
# include/tesseract/pageiterator.h
# include/tesseract/version.h
# include/tesseract/resultiterator.h
# include/tesseract/publictypes.h
# include/tesseract/osdetect.h
# include/tesseract/baseapi.h
# lib/pkgconfig/tesseract.pc
# lib/cmake/tesseract/TesseractConfig.cmake
# lib/cmake/tesseract/TesseractTargets-release.cmake
# lib/cmake/tesseract/TesseractConfigVersion.cmake
# lib/cmake/tesseract/TesseractTargets.cmake
# lib/libtesseract.so
# bin/tesseract
