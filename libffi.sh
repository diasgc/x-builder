#!/bin/bash

lib='libffi'
dsc='A portable foreign-function interface library'
lic='Free'
src='https://github.com/libffi/libffi.git'
cfg='ar'
eta='15'
CFG='--enable-portable-binary --disable-docs'

lst_inc='ffitarget.h ffi.h'
lst_lib='libffi.*'
lst_bin=''
lst_lic='LICENSE LICENSE-BUILDTOOLS'
lst_pc='libffi.pc'

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc
