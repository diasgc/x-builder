#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='soxr'
apt='libsoxr-dev'
dsc='The SoX resampler library'
lic='LGPL-2.1'
src='https://git.code.sf.net/p/soxr/code'
sty='git'
cfg='cm'
eta='45'

. xbuilder.sh

CFG="-DBUILD_TESTS=OFF"

start


# Filelist
# --------

# include/soxr-lsr.h
# include/soxr.h
# lib/pkgconfig/soxr.pc
# lib/pkgconfig/soxr-lsr.pc
# lib/libsoxr-lsr.so
# lib/libsoxr.so
# share/doc/libsoxr/NEWS
# share/doc/libsoxr/LICENCE
# share/doc/libsoxr/README
