#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN +++  .   .   .  clang/gcc


lib='oniguruma'
dsc='Regular expression library'
lic='BSD-2c'
src='https://github.com/kkos/oniguruma.git'
cfg='cmake'
eta='22'
lst_inc='oniggnu.h oniguruma.h'
lst_lib='libonig'
lst_bin='onig-config'

. xbuilder.sh

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
