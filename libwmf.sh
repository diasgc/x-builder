#!/bin/bash
#             a8  a7  x86 x64
# ndk-clang    F  ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libwmf'
apt='libwmf-dev'
dsc='Library for Converting Metafile Images'
lic='GPL-2.0'
src='https://github.com/caolanm/libwmf.git'
cfg='ac'
dep='freetype expat libpng libjpeg'
eta='60'
cb0='--disable-heavy'

lst_inc=''
lst_lib=$lib
lst_bin=''
lst_oth=''

. xbuilder.sh

start