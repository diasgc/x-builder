#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++o ++o ... ...
# linux-gnu   ++o ... ... ...
# mingw-llvm  ++o ... ... ...

lib='libb2'
apt='libb2-dev'
dsc='BLAKE2 family of hash functions'
lic='CC0-1.0'
src='https://github.com/BLAKE2/libb2.git'
cfg='autom'
eta='100'

#CFG-defaults
#--enable-native=yes --enable-fat=no --disable-openmp

lst_inc='blake2.h'
lst_lib='libb2.*'
lst_bin=''
lst_lic='COPYING'
lst_pc='libb2.pc'

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK ++  ++   .   .  clang
# GNU ++   .   .   .  gcc
# WIN ++   .   .   .  clang/gcc
