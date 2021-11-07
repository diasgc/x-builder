#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   F.. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='djview'
apt='djview4'
dsc='Multi-format archive and compression library'
lic='GPL'
vrs='4.12'
src="http://downloads.sourceforge.net/djvu/djview-${vrs}.tar.gz"
cfg='autom'
eta='100'

lst_inc=''
lst_lib=$lib
lst_bin=''
lst_oth=''

. xbuilder.sh

start
