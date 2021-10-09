#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++  ++   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libao'
dsc='Audio output portability library.'
lic='GPL-2'
src='https://gitlab.xiph.org/xiph/libao.git'
sty='git'
cfg='ag'
pkg='ao'
eta='60'

lst_inc='ao/ao.h ao/plugin.h'
lst_lib='libao'
lst_bin=''

. xbuilder.sh

build_patch_config(){
	#no docs
	sed -i '/^SUBDIRS/ {s/ doc//}' $SRCDIR/Makefile
}

start

# Filelist
# --------
# include/ao/ao.h
# include/ao/plugin.h
# include/ao/os_types.h
# lib/pkgconfig/ao.pc
# lib/libao.a
# lib/ckport/db/libao.ckport
# lib/libao.so
# lib/libao.la
# share/man/man5/libao.conf.5
# share/aclocal/ao.m4
