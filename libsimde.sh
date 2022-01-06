#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libsimde'
dsc='Implementations of SIMD instruction sets for systems which dont natively support them'
lic='MIT'
src='https://github.com/simd-everywhere/simde.git'
cfg='meson'
eta='0'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start