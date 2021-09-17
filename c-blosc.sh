#!/bin/bash

lib='c-blosc'
pkg='blosc'
apt='libblosc-dev'
dsc='A blocking, shuffling and loss-less compression library that can be faster than memcpy().'
lic='Other'
src='https://github.com/Blosc/c-blosc.git'
sty='git'
cfg='cm'
cstk='BUILD_STATIC'
cshk='BUILD_SHARED'
eta='100'

. xbuilder.sh

CFG='-DBUILD_TESTS=OFF'
case $arch in a*) CFG="-DDEACTIVATE_SSE2=ON -DDEACTIVATE_AVX2=ON $CFG";; esac

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared

# Filelist
# --------
# include/blosc-export.h
# include/blosc.h
# lib/libblosc.so
# lib/pkgconfig/blosc.pc
# lib/libblosc.a
