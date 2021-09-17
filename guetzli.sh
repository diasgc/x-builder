#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin


lib='guetzli'
dsc='Perceptual JPEG encoder'
lic='Apache-2.0'
src='https://github.com/google/guetzli.git'
sty='git'
cfg='mk'
dep='libpng'
eta='60'

. xbuilder.sh

start