#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='lz4'
pkg='liblz4'
apt='liblz4-dev'
dsc='Fast LZ compression algorithm library'
lic='BSD-2c GPL2.0'
src="https://github.com/lz4/lz4.git"
cfg='mk'
eta='20'

lst_inc='lz4.h lz4frame.h lz4frame_static.h lz4hc.h'
lst_lib='liblz4'
lst_bin='lz4'
lst_lic='LICENSE'
lst_pc='liblz4.pc'

. xbuilder.sh

CFG="CC=${CC} CXX=${CXX}"

build_install(){
	# INSTALL_DIR collides with internal Makefile variable, better unset
	#local id=$dir_install
	#unset INSTALL_DIR
	pushdir $dir_src
	do_log 'install' ${MAKE_EXECUTABLE} prefix=${dir_install} install
	mkd="prefix=$(build_packages_getdistdir) install"
	mkd_suffix="/"
	popdir
}

start

# Filelist
# --------

# include/lz4.h
# include/lz4frame.h
# include/lz4hc.h
# include/lz4frame_static.h
# lib/pkgconfig/liblz4.pc
# lib/liblz4.so.1.9.3
# lib/liblz4.a
# share/man/man1/lz4.1
# share/doc/lz4/LICENSE
# bin/lz4
