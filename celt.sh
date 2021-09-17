#!/bin/bash

lib='celt'
apt=''
dsc='CELT is a low-delay audio codec'
lic='BSD 2-clause'
src='https://gitlab.xiph.org/xiph/celt.git'
sty='git'
cfg='ag'
dep='ogg'
eta='60'
mki="install-strip"
mkc='distclean'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --enable-experimental-postfilter --enable-float-approx --enable-fixed-point --enable-custom-modes --with-pic"

source_patch(){
  sed -i 's|XIPH_PATH_OGG|#XIPH_PATH_OGG|g' $SRCDIR/configure
}

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared

# Filelist
# --------
# include/celt/celt_header.h
# include/celt/celt_types.h
# include/celt/celt.h
# lib/pkgconfig/celt.pc
# lib/libcelt0.so
# lib/libcelt0.a
# lib/libcelt0.la
