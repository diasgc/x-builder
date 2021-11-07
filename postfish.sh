#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   F   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='postfish'
dsc='A digital audio post-processing, restoration, filtering and mixdown tool.'
lic='GPL-2'
src='https://gitlab.xiph.org/xiph/postfish.git'
cfg='mk'
tls='libgtk2.0-dev libfftw3-bin'
dep='libao fftw'
pkg='postfish'
eta='60'

. xbuilder.sh

CFG="CC=$CC LD=$CC PREFIX=$INSTALL_DIR"

_source_patch(){
  sed -i 's|gtk+-2.0 ao|gtk+-2.0 ao fftw|' $SRCDIR/Makefile
}

start