#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++ +++  .  clang
# GNU  .   .   .   .  gcc
# WIN +++ +++  .  +++ clang/gcc

lib='x264'
dsc='x264, the best and fastest H.264 encoder'
lic='GPL-2.0'
src='https://code.videolan.org/videolan/x264.git'
cfg='ac'
eta='60'
cbk="able-cli"
lst_inc='x264.h x264_config.h'
lst_lib='libx264'
lst_bin='x264'

. xbuilder.sh

[ "$ABI" == "x86_64" ] && AS=nasm || CFG+=" --disable-asm"

start

# Filelist
# --------
# include/x264.h
# include/x264_config.h
# lib/pkgconfig/x264.pc
# lib/libx264.a
# lib/libx264.so.164
# bin/x264
