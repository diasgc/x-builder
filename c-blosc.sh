#!/bin/bash

lib='c-blosc'
pkg='blosc'
apt='libblosc-dev'
dsc='A blocking, shuffling and loss-less compression library that can be faster than memcpy().'
lic='Other'
src='https://github.com/Blosc/c-blosc.git'
cfg='cmake'
cstk='BUILD_STATIC'
cshk='BUILD_SHARED'
eta='100'

lst_inc='blosc-export.h blosc.h'
lst_lib='libblosc'
lst_bin=''

. xbuilder.sh

CFG='-DBUILD_TESTS=OFF'
$host_arm && CFG="-DDEACTIVATE_SSE2=ON -DDEACTIVATE_AVX2=ON $CFG"

start

# cpu av8 av7 x86 x64
# NDK ++. ++. ++. ++. clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# Filelist
# --------
# include/blosc-export.h
# include/blosc.h
# lib/libblosc.so
# lib/pkgconfig/blosc.pc
# lib/libblosc.a
