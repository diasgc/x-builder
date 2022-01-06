#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   +   +   .   .   F  static
#  +   +   +   +   +   +   +   +   .   .   F  shared
#  +   +   +   +   +   +   +   +   .   .   F  bin

lib='davs2'
dsc='An open-source decoder of AVS2-P2/IEEE1857.4 video coding standard'
lic='GPL-2.0'
src='https://github.com/pkuvcl/davs2.git'
cfg='ac'
eta='40'
cb0="--disable-cli"

. xbuilder.sh

AS=nasm
CFG="--cross-prefix=${CROSS_PREFIX}"
SRCDIR=$SRCDIR/build/linux

case $arch in
  aarch*|arm*|i686-*android ) CFG="$CFG --disable-asm" CFLAGS="$CFLAGS -mfpu=neon";;&
  *android*) LDFLAGS="$LDFLAGS -L$SYSROOT/usr/lib -llog";;
esac

start