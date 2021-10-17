#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='librist'
dsc='A library that can be used to easily add the RIST protocol to your application.'
lic='BSD-2c'
src='https://code.videolan.org/rist/librist.git'
cfg='meson'
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
# include/librist/logging.h
# include/librist/librist.h
# include/librist/udpsocket.h
# include/librist/librist_srp.h
# include/librist/common.h
# include/librist/headers.h
# include/librist/version.h
# lib/pkgconfig/librist.pc
# lib/librist.so
# lib/librist.a
# bin/ristreceiver
# bin/ristsrppasswd
# bin/rist2rist
# bin/ristsender
