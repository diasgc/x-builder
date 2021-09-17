#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='uchardet'
dsc='an encoding detector library'
lic='GPL-2'
src='https://gitlab.freedesktop.org/uchardet/uchardet.git'
sty='git'
cfg='cm'
eta='60'
cbk="BUILD_BINARY"

. xbuilder.sh

CFG="-DUSE_OMP=OFF"

case $arch in
  aarch64*|arm* ) CFG="$CFG -DCHECK_SSE2=OFF";;
  i686*|x86_64* ) CFG="$CFG -DCHECK_SSE2=ON";;
esac

start

# Filelist
# --------

# include/uchardet/uchardet.h
# lib/libuchardet.a
# lib/pkgconfig/uchardet.pc
# lib/libuchardet.so
# share/man/man1/uchardet.1
# bin/uchardet
