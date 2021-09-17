#!/bin/bash

lib='brotli'
pkg='libbrotlicommon'
dsc='Lossless compression algorithm and format'
lic='MIT'
src='https://github.com/google/brotli.git'
sty='git'
cfg='cm'
eta='60'

. xbuilder.sh

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   .   .   .   .   .   .   .  static
#  +   +   .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

# Filelist
# --------

# include/brotli/shared_dictionary.h
# include/brotli/port.h
# include/brotli/types.h
# include/brotli/decode.h
# include/brotli/encode.h
# lib/pkgconfig/libbrotlidec.pc
# lib/pkgconfig/libbrotlicommon.pc
# lib/pkgconfig/libbrotlienc.pc
# lib/libbrotlidec.so
# lib/libbrotlienc-static.a
# lib/libbrotlienc.so
# lib/libbrotlicommon.so
# lib/libbrotlicommon-static.a
# lib/libbrotlidec-static.a
# bin/brotli
