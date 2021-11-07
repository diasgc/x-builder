#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libdca'
dsc='Free library to decode DTS Coherent Acoustics streams'
lic='GLP-2.0'
src='https://code.videolan.org/videolan/libdca.git'
cfg='ar'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

ndk_assert_h_sys_soundcard

start

# Filelist
# --------
# include/dts.h
# include/dca.h
# lib/pkgconfig/libdca.pc
# lib/pkgconfig/libdts.pc
# lib/libdca.la
# lib/libdca.a
# lib/libdca.so
# share/man/man1/extract_dca.1
# share/man/man1/dcadec.1
# bin/dcadec
# bin/extract_dca
# bin/dtsdec
# bin/extract_dts
