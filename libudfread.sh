#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libudfread'
dsc='UDF filesystem access library'
lic='LGPL-2.1'
src='https://code.videolan.org/videolan/libudfread.git'
sty='git'
cfg='ar'
eta='20'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start

# Filelist
# --------
# include/udfread/udfread.h
# include/udfread/blockinput.h
# include/udfread/udfread-version.h
# lib/libudfread.la
# lib/pkgconfig/libudfread.pc
# lib/libudfread.a
# lib/libudfread.so
