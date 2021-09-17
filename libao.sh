#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libao'
dsc='Audio output portability library.'
lic='GPL-2'
src='https://gitlab.xiph.org/xiph/libao.git'
sty='git'
cfg='ag'
dep='libpulse'
pkg='ao'
eta='60'

. xbuilder.sh

CFG="--with-pic=1"

start