#!/bin/bash

# cpu av8 av7 x86 x64
# NDK +X+  .   .   .  clang
# GNU +..  .   .   .  gcc
# WIN +..  .   .   .  clang/gcc

lib='vpx'
dsc='WebM Project VPx codec implementation'
lic='GPL?'
src='https://chromium.googlesource.com/webm/libvpx'
sty='git'
cfg='ac'
eta='240'
mki='install'
cbk='able-examples'
ac_nohost=true
ac_nosysroot=true
ac_nopic=true
disable_shared=true # --enable-shared only supported on ELF, OS/2, and Darwin for now

lst_inc='vpx/vpx_ext_ratectrl.h
	vpx/vpx_frame_buffer.h
	vpx/vpx_integer.h
	vpx/vpx_decoder.h
	vpx/vpx_image.h
	vpx/vp8cx.h
	vpx/vpx_codec.h
	vpx/vpx_encoder.h
	vpx/vp8.h
	vpx/vp8dx.h'
lst_lib='libvpx'
lst_bin='vpxenc vpxdec'

. xbuilder.sh

CFG="--disable-docs --disable-install-srcs --disable-install-docs --disable-tools --disable-unit-tests"
  #--enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-vp9-temporal-denoising --enable-vp9-postproc \
  #--enable-postproc --enable-onthefly-bitpacking --enable-multi-res-encoding --enable-better-hw-compatibility \
  #--enable-webm-io --enable-libyuv --enable-experimental --enable-pic "

t0=(arm64 armv7 x86 x86_64)
$host_x86 && t1=(android linux win32) || t1=(android linux win64)
CFG+=" --target=${t0[`expr ${cpu_id} % 4`]}-${t1[`expr ${cpu_id} / 4`]}-gcc"
$host_arm && CFG+=' --enable-neon'
$host_arm32 && CFG+=' --disable-neon-asm'
AS=$YASM

start

# Filelist
# --------
# include/vpx/vpx_ext_ratectrl.h
# include/vpx/vpx_frame_buffer.h
# include/vpx/vpx_integer.h
# include/vpx/vpx_decoder.h
# include/vpx/vpx_image.h
# include/vpx/vp8cx.h
# include/vpx/vpx_codec.h
# include/vpx/vpx_encoder.h
# include/vpx/vp8.h
# include/vpx/vp8dx.h
# lib/pkgconfig/vpx.pc
# lib/libvpx.a
# bin/vpxenc
# bin/vpxdec