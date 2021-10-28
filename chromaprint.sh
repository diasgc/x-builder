#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  P   P   P   P  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='chromaprint'
pkg='libchromaprint'
apt='libchromaprint1'
dsc='C library for generating audio fingerprints used by AcoustID'
lic='LGPL-2.1'
src='https://github.com/acoustid/chromaprint.git'
cfg='cmake'
eta='12'
# cb0="-DBUILD_TOOLS=OFF"
# cb1="-DBUILD_TOOLS=OFF" # disable bin: cannot build bin (requires FFMPEG_LIBXXXXX_INCLUDE_DIRS)

. xbuilder.sh
CFG="-DKISSFFT_SOURCE_DIR=${SRCDIR}/vendor/kissfft -DBUILD_TOOLS=OFF"

start

# Filelist
# --------
# include/chromaprint.h
# lib/pkgconfig/libchromaprint.pc
# lib/libchromaprint.so
