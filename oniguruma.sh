#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='oniguruma'
dsc='Regular expression library'
lic='BSD-2c'
src='https://github.com/kkos/oniguruma.git'
sty='git'
cfg='cm'
eta='22'
mkc='distclean'
mki='install-strip'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start

# Filelist
# --------
# include/oniggnu.h
# include/oniguruma.h
# lib/pkgconfig/oniguruma.pc
# lib/libonig.a
# lib/libonig.so
# lib/libonig.la
# bin/onig-config
