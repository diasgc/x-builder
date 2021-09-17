#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='x265'
apt='x265'
dsc='x265 is an open source HEVC encoder'
lic='GPL-2.0'
src='https://github.com/videolan/x265.git'
sty='git'
cfg='cm'
tls='yasm libnuma-dev'

eta='720'
cb0="-DENABLE_CLI=OFF"
cb1="-DENABLE_CLI=ON"
# -----------------------------------------

. xbuilder.sh $@ --ndkLpthread

#-DHIGH_BIT_DEPTH=ON
BUILD_DIR=$SRCDIR/build_${arch}
SRCDIR=$SRCDIR/source
AS=$YASM
case $arch in
  *mingw32 ) CFG="$CFG -DENABLE_LUMA=OFF";;
  aarch64*|arm* ) CFG="$CFG -DCROSS_COMPILE_ARM=ON -DENABLE_ASSEMBLY=OFF";;
esac

start

# Filelist
# --------

# include/x265.h
# include/x265_config.h
# lib/pkgconfig/x265.pc
# lib/libx265.so
# lib/libx265.a
# bin/x265
