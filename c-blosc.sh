#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++. ++. ++. ++. clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='c-blosc'
pkg='blosc'
apt='libblosc-dev'
dsc='A blocking, shuffling and loss-less compression library that can be faster than memcpy().'
lic='Other'
src='https://github.com/Blosc/c-blosc.git'
cfg='cm'
cstk='BUILD_STATIC'
cshk='BUILD_SHARED'
eta='100'

. xbuilder.sh

CFG='-DBUILD_TESTS=OFF'
$host_arm && CFG="-DDEACTIVATE_SSE2=ON -DDEACTIVATE_AVX2=ON $CFG"

start

# Filelist
# --------
# include/blosc-export.h
# include/blosc.h
# lib/libblosc.so
# lib/pkgconfig/blosc.pc
# lib/libblosc.a
