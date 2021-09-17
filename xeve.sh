#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  X   X   +   +   +   .   X   X   .   .   .  static
#  X   X   +   +   .   .   X   X   .   .   .  shared
#  X   X   +   +   .   .   X   X   .   .   .  bin

lib='xeve'
dsc='eXtra-fast Essential Video Encoder, MPEG-5 EVC (Essential Video Coding)'
lic='Other'
src='https://github.com/mpeg5/xeve.git'
sty='git'
cfg='cm'
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
