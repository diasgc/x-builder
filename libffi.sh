#!/bin/bash
# cpu av8 av7 x86 x64
# NDK ++.  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libffi'
dsc='A portable foreign-function interface library'
lic='Free'
src='https://github.com/libffi/libffi.git'
cfg='ar'
eta='15'
CFG='--enable-portable-binary --disable-docs'

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
# include/ffitarget.h
# include/ffi.h
# lib/pkgconfig/libffi.pc
# lib/libffi.a
# lib/libffi.la
# lib/libffi.so.8.1.0
# share/man/man3/ffi_prep_cif_var.3
# share/man/man3/ffi.3
# share/man/man3/ffi_call.3
# share/man/man3/ffi_prep_cif.3
