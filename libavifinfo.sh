#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libavifinfo'
dsc='Provides high level information about the AVIF container'
lic='GLP-2.0'
src='https://aomedia.googlesource.com/libavifinfo.git'
cfg='cmake'
eta='0'
cbk='AVIFINFO_BUILD_TOOLS'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start