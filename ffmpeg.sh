#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='ffmpeg'
dsc='ffmpeg'
lic='GLP-2.0'
src='https://git.ffmpeg.org/gitweb/ffmpeg.git'
cfg='ac'
eta='60'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start