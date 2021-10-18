#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN +++  .   .   .  clang/gcc

lib='shine'
dsc='Super fast fixed-point MP3 encoder.'
lic='GLP-2.0'
src='https://github.com/toots/shine.git'
cfg='ac'
automake_cmd='./bootstrap'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start

# Filelist
# --------
# include/shine/layer3.h
# lib/pkgconfig/shine.pc
# lib/libshine.a
# lib/libshine.la
# lib/libshine.so
# bin/shineenc
