#!/bin/bash

lib='c-blosc2'
pkg='blosc2'
apt='libblosc-dev'
dsc='A fast, compressed, persistent binary data store library for C.'
lic='BSD-3c'
src='https://github.com/Blosc/c-blosc2.git'
sty='git'
cfg='cm'
eta='140'

. xbuilder.sh

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  -   -   -   -   .   .   .   .   .   .   .  bin

# Filelist
# --------
# include/blosc2/filters-registry.h
# include/blosc2/blosc2-stdio.h
# include/blosc2/blosc2-export.h
# include/blosc2/blosc2-common.h
# include/blosc2/codecs-registry.h
# include/blosc2.h
# lib/pkgconfig/blosc2.pc
# lib/libblosc2.a
# lib/libblosc2.so
