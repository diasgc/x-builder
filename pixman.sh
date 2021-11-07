#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='pixman'
apt='libpixman-1-dev'
pkg='pixman-1'
dsc='Pixel-manipulation library for X and cairo'
lic='GPL-2.0'
src='https://github.com/freedesktop/pixman.git'
sty='git'
cfg='ag'
dep='libpng'
eta='275'

. xbuilder.sh

[ "${arch}" == "arm-linux-androideabi" ] && {
    pushvar_f dep 'cpu_features'
    pushvar_l CFG '--disable-arm-neon --disable-arm-simd'
    pushvar_f CPPFLAGS "-Wno-unused-const-variable"
}

start

# Filelist
# --------

# include/pixman-1/pixman-version.h
# include/pixman-1/pixman.h
# lib/pkgconfig/pixman-1.pc
# lib/libpixman-1.a
# lib/libpixman-1.la
# lib/libpixman-1.so
