#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+  .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libavif'
dsc='Library for encoding and decoding .avif files'
lic='BSD?'
src='https://github.com/AOMediaCodec/libavif.git'
sty='git'
cfg='cm'
dep='aom libjpeg libpng'
pkg='libavif'
eta='30'
cbk='AVIF_BUILD_APPS'
cmake_path='lib/cmake/libavif'

. xbuilder.sh

CFG="-DAVIF_BUILD_EXAMPLES=OFF -DAVIF_BUILD_TESTS=OFF -DAVIF_CODEC_AOM=ON"

start

# Filelist
# --------

# include/avif/avif.h
# lib/pkgconfig/libavif.pc
# lib/cmake/libavif/libavif-config-release.cmake
# lib/cmake/libavif/libavif-config-version.cmake
# lib/cmake/libavif/libavif-config.cmake
# lib/libavif.so
# bin/avifdec
# bin/avifenc
