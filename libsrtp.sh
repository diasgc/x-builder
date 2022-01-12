#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP-  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc
# latest: v2.4.0

lib='libsrtp'
dsc='Library for SRTP (Secure Realtime Transport Protocol)'
lic='BSD-3c'
src='https://github.com/cisco/libsrtp.git'
cfg='cmake'
eta='0'
pc_llib='-lsrtp2'

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
# include/srtp2/cipher.h
# include/srtp2/srtp.h
# include/srtp2/crypto_types.h
# include/srtp2/auth.h
# lib/pkgconfig/libsrtp.pc
# lib/libsrtp2.so
