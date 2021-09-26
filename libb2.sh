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
lst_lib=$lib
lst_bin=''
lst_oth=''

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start


# Filelist
# --------
# include/blake2.h
# lib/pkgconfig/libb2.pc
# lib/libb2.so
# lib/libb2.a
# lib/libb2.la
