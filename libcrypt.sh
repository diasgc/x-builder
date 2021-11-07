#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libcrypt'
dsc='The GNU crypto library'
lic='GLP-2.0'
src='https://github.com/gpg/libgcrypt.git'
dep='libgpg-error'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh
CFG="--with-libgpg-error-prefix=$LIBSDIR --with-capabilities --disable-doc"
start