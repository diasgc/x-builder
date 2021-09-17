#!/bin/bash

lib='chromaprint'
pkg='libchromaprint'
apt='libchromaprint1'
dsc='C library for generating audio fingerprints used by AcoustID'
lic='LGPL-2.1'
src='https://github.com/acoustid/chromaprint.git'
sty='git'
cfg='cm'
eta='12'
cb0="-DBUILD_TOOLS=OFF"
cb1="-DBUILD_TOOLS=OFF" # disable bin: cannot build bin (requires FFMPEG_LIBXXXXX_INCLUDE_DIRS)

. xbuilder.sh
CFG="-DKISSFFT_SOURCE_DIR=${SRCDIR}/vendor/kissfft"

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  F   F   F   F   .   .   .   .   .   .   .  bin

# Filelist
# --------
# include/chromaprint.h
# lib/pkgconfig/libchromaprint.pc
# lib/libchromaprint.so
