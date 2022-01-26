#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  F   .   .   F  clang/gcc

ver='4.3.5'
lib='libzmq'
dsc='ZeroMQ core engine in C++, implements ZMTP/3.1'
lic='GLP-2.0'
src='https://github.com/zeromq/libzmq.git'
cfg='ar'
eta='0'
dep='libsodium'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''
lst_lic='COPYING COPYING.LESSER AUTHORS'
lst_pc=''

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