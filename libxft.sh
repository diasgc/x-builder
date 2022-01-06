#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libxft'
dsc='FreeType-based font drawing library for X'
lic='MIT'
src='https://gitlab.freedesktop.org/xorg/lib/libxft.git'
cfg='ag'
dep='fontconfig freetype libbz2 liblzma libpng libuuid libx11 libxau libxcb libxdmcp libxml2 libxrender'
eta='0'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start