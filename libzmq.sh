#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libzmq'
dsc=''
lic='GLP-2.0'
src='https://github.com/zeromq/libzmq.git'
cfg='ag'
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
# include/zmq.h
# include/zmq_utils.h
# lib/pkgconfig/libzmq.pc
# lib/libzmq.la
# lib/libzmq.a
# lib/libzmq.so
# bin/curve_keygen
