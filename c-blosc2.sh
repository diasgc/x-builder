#!/bin/bash
# cpu av8 av7 x86 x64
# NDK ++. ++. ++. ++. clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='c-blosc2'
pkg='blosc2'
apt='libblosc-dev'
dsc='A fast, compressed, persistent binary data store library for C.'
lic='BSD-3c'
src='https://github.com/Blosc/c-blosc2.git'
cfg='cmake'
eta='140'

lst_inc='blosc2/filters-registry.h
	blosc2/blosc2-stdio.h
	blosc2/blosc2-export.h
	blosc2/blosc2-common.h
	blosc2/codecs-registry.h
	blosc2.h'
lst_lib='libblosc2'
lst_bin=''

. xbuilder.sh

start

# Filelist
# --------
# include/blosc2/filters-registry.h
# include/blosc2/blosc2-stdio.h
# include/blosc2/blosc2-export.h
# include/blosc2/blosc2-common.h
# include/blosc2/codecs-registry.h
# include/blosc2.h
# lib/pkgconfig/blosc2.pc
# lib/libblosc2.a
# lib/libblosc2.so
