#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libcap'
dsc='Library for getting and setting POSIX.1e (formerly POSIX 6) draft 15 capabilities'
lic='GLP-2.0'
src='https://kernel.googlesource.com/pub/scm/linux/kernel/git/morgan/libcap'
cfg='make'
eta='0'

mkf='CC="$CC -Wl,-rpath='${dir_install_lib}' -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy PREFIX="'${dir_install}'" PTHREADS=no'
mki='CC="$CC -Wl,-rpath='${dir_install_lib}' -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy prefix="'${dir_install}'" RAISE_SETFCAP=no lib=/lib PTHREADS=no install'
dev_bra='main'
dev_vrs=''
stb_bra=''
stb_vrs=''

lst_inc=''
lst_lib=''
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc=''

eta='20'

. xbuilder.sh

start