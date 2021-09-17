#!/bin/bash

lib='xavs2'
dsc='An open-source encoder of AVS2-P2/IEEE1857.4 video coding standard'
lic='GPL-2.0'
src='https://github.com/pkuvcl/xavs2.git'
sty='git'
cfg='ac'
eta='40'
cb0="--disable-cli"
cb1=''

. xbuilder.sh

SRCDIR=$SRCDIR/build/linux
CFG="--sysroot=${SYSROOT} --enable-lto --enable-strip --enable-pic"
case $arch in
    aarch*|arm*|*64-*) CFG="$CFG --disable-asm";;
    *) AS=NASM;;
esac

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  +   +   +   +   .   .   .   .   .   .   .  bin

# Filelist
# --------------------------------------------
# include/xavs2_config.h
# include/xavs2.h
# lib/pkgconfig/xavs2.pc
# lib/libxavs2.so.13
# lib/libxavs2.a
# bin/xavs2
