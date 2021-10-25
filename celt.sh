#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++  ++  ++  ++  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='celt'
dsc='CELT is a low-delay audio codec'
lic='BSD-2c'
src='https://gitlab.xiph.org/xiph/celt.git'
cfg='ag'
dep='ogg'
eta='60'
CFG="--enable-experimental-postfilter \
     --enable-float-approx \
     --enable-fixed-point \
     --enable-custom-modes"
lst_inc='celt/celt_header.h celt/celt_types.h celt/celt.h'
lst_lib='libcelt0'
lst_bin=''

. xbuilder.sh

source_patch(){
  sed -i 's|XIPH_PATH_OGG|#XIPH_PATH_OGG|g' $SRCDIR/configure
}

start

# Filelist
# --------
# include/celt/celt_header.h
# include/celt/celt_types.h
# include/celt/celt.h
# lib/pkgconfig/celt.pc
# lib/libcelt0.so
# lib/libcelt0.a
# lib/libcelt0.la
