#!/bin/bash

lib='xvidcore'
dsc='Xvid decoder/encoder library'
lic='GPL'
url='https://labs.xvid.com/source/'
vrs="1.3.7"
src="https://downloads.xvid.com/downloads/xvidcore-${vrs}.tar.gz"
cfg='ac'
eta='20'

pc_url=$url
pc_llib='-lxvidcore'

lst_inc='xvid.h'
lst_lib='libxvidcore'
lst_bin=''

. xbuilder.sh

unset CSH # unsupported static/shared tags
SRCDIR=$SRCDIR/build/generic


case $arch in
	i686-linux-android) CFG="$CFG --disable-assembly";;
esac

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared

# Filelist
# --------
# include/xvid.h
# lib/pkgconfig/xvidcore.pc
# lib/libxvidcore.so.4.3
# lib/libxvidcore.a