#!/bin/bash
#             a8  a7  x86 x64
# ndk-clang   +++ +++ +++ +++
# linux-gnu   +++ ... ... ...
# mingw-llvm  F   F   ... +++

lib='x265'
dsc='x265 is an open source HEVC encoder'
lic='GPL-2.0'
src='https://github.com/videolan/x265.git'
cfg='cm'
tls='yasm libnuma-dev'
eta='720'
cbk="ENABLE_CLI"

CFG='-DHIGH_BIT_DEPTH=ON'

lst_inc='x265.h x265_config.h'
lst_lib='libx265'
lst_bin='x265'
lst_oth=''

. xbuilder.sh #$@ --ndkLpthread

SRCDIR+='/source'

str_contains $arch mingw32 && CFG+=" -DENABLE_LUMA=OFF"
str_starts $arch a && CFG+=" -DCROSS_COMPILE_ARM=ON -DENABLE_ASSEMBLY=OFF"

start


# Filelist
# --------
# include/x265.h
# include/x265_config.h
# lib/pkgconfig/x265.pc
# lib/libx265.so
# lib/libx265.a
# bin/x265
