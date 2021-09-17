#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   f   +   .   .   .   .   .   .   .  static
#  +   +   f   +   .   .   .   .   .   .   .  shared
#  +   +   f   +   .   .   .   .   .   .   .  bin

lib='x264'
dsc='x264, the best and fastest H.264 encoder'
lic='GPL-2.0'
src='https://code.videolan.org/videolan/x264.git'
sty='git'
cfg='ac'
eta='60'
cb0="--disable-cli"
cb1="--enable-cli"

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"
case $arch in aarch64*|arm*) CFG="$CFG --disable-asm";;esac
export AS=nasm

start

# Filelist
# --------

# include/x264.h
# include/x264_config.h
# lib/pkgconfig/x264.pc
# lib/libx264.a
# lib/libx264.so.164
# bin/x264
