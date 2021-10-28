#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libudfread'
dsc='UDF filesystem access library'
lic='LGPL-2.1'
src='https://code.videolan.org/videolan/libudfread.git'
sty='git'
cfg='ar'
eta='20'

. xbuilder.sh

start

# Filelist
# --------
# include/udfread/udfread.h
# include/udfread/blockinput.h
# include/udfread/udfread-version.h
# lib/libudfread.la
# lib/pkgconfig/libudfread.pc
# lib/libudfread.a
# lib/libudfread.so
