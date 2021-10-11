#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libx11'
dsc='Core X11 protocol client library'
lic='Other'
src='https://gitlab.freedesktop.org/xorg/lib/libx11.git'
cfg='ag'
eta='0'
dep='xorg-macros'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start