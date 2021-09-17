#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='xavs'
dsc='High quality encoder and decoder of the Audio Video Standard of China (AVS)'
lic='GPL-2.0'
src='https://svn.code.sf.net/p/xavs/code/trunk'
sty='svn'
cfg='ac'
eta='30'

. xbuilder.sh

CFG="--disable-asm --enable-pic"

case $arch in
  arm-linux*|aarch64-linux* ) CFG="--host=arm-linux-gnu $CFG" ;;
  x86_64-linux* ) CFG="--host=x86_64-linux-gnu $CFG" ;;
  i686-linux* ) CFG="--host=i686-linux-gnu $CFG" ;;
  *-w64-mingw32 ) CFG="--host=${arch} $CFG" ;;
esac

start

# Filelist
# --------

# include/xavs.h
# lib/pkgconfig/xavs.pc
# lib/libxavs.a
# lib/libxavs.so.1
# bin/xavs