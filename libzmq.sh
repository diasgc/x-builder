#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  F   .   .   F  clang/gcc

lib='libzmq'
dsc=''
lic='GLP-2.0'
src='https://github.com/zeromq/libzmq.git'
cfg='ag'
eta='0'
dep='libsodium'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

CFG='--disable-Werror --with-libsodium'

start

# Filelist
# --------
# include/zmq.h
# include/zmq_utils.h
# lib/pkgconfig/libzmq.pc
# lib/libzmq.la
# lib/libzmq.a
# lib/libzmq.so
# bin/curve_keyge