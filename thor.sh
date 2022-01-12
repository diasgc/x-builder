#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='thor'
dsc='Thor Video Codec'
lic='BSD-2c'
src='https://github.com/cisco/thor.git'
cfg='make'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh
ARCH=neon
CFLAGS+=" -march=armv8-a+simd -mtune=cortex-a75"
start