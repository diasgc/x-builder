#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='vo-amrwbenc'
apt='libvo-amrwbenc-dev'
dsc='VisualOn Adaptive Multi-Rate Wideband speech codec library'
lic='Apache-2.0'
src='https://github.com/mstorsjo/vo-amrwbenc.git'
sty='git'
cfg='ar'
eta='36'

. xbuilder.sh

start

# Filelist
# --------

# include/vo-amrwbenc/enc_if.h
# lib/pkgconfig/vo-amrwbenc.pc
# lib/libvo-amrwbenc.so
# lib/libvo-amrwbenc.a
# lib/libvo-amrwbenc.la
