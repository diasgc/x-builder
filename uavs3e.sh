#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='uavs3e'
dsc='AVS3 encoder which supports AVS3-P2 baseline profile.'
lic='Other'
src='https://github.com/uavs3/uavs3e.git'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start