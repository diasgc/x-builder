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
ac_nopic=true
ac_nosysroot=true
cb0="disable-cli"
cb1=
lst_inc='x264.h x264_config.h'
lst_lib='libx264'
lst_bin='x264'

. xbuilder.sh

CFG="--enable-lto --enable-pic --enable-strip" # --extra-cflags=\"$CPPFLAGS\" --extra-ldflags=\"$LDFLAGS\""
CFG+=" --sysroot=${SYSROOT} --cross-prefix=${CROSS_PREFIX}"
$host_x64 && AS=nasm || CFG+=" --disable-asm"

start

# Filelist
# --------
# include/x264.h
# include/x264_config.h
# lib/pkgconfig/x264.pc
# lib/libx264.a
# lib/libx264.so.164
# bin/x264
