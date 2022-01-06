#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +X+  .   .   .  clang
# GNU +..  .   .   .  gcc
# WIN +..  .   .   .  clang/gcc

lib='ffevc'
dsc='ffmpeg supporting EVC codec and file formats'
lic='BSD-2c'
src='https://github.com/mpeg5/ffevc.git'
cfg='cmake'
cstk="XEVE_APP_STATIC_BUILD"

. xbuilder.sh

case $arch in aarch64*|arm*) doErr "${lib} does not support cross-build for arm devices (${arch}).";; esac

start

# Filelist
# --------
# include/xeve/xeve.h
# include/xeve/xeve_exports.h
# lib/pkgconfig/xeve.pc
# lib/xeve/libxeve.a
# lib/libxeve.so
# bin/xeve_app
