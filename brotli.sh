#!/bin/bash

lib='brotli'
pkg='libbrotlicommon'
dsc='Lossless compression algorithm and format'
lic='MIT'
src='https://github.com/google/brotli.git'
cfg='cmake'
eta='60'

lst_inc='brotli/shared_dictionary.h
	brotli/port.h
	brotli/types.h
	brotli/decode.h
	brotli/encode.h'
lst_lib='libbrotlidec libbrotlienc libbrotlicommon
    libbrotlicommon-static libbrotlicommon-static
    libbrotlicommon-static'
lst_bin='brotli'

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK +++ +++  .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

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
