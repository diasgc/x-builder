#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='sevenzipjbinding'
dsc=''
lic='GLP-2.0'
src='https://github.com/borisbrodski/sevenzipjbinding.git'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start