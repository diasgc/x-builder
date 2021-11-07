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
sty='git'
cfg='mk'
eta='10'

. xbuilder.sh

CFG="CC=${CC} CXX=${CXX}"

build_install(){
	# INSTALL_DIR collides with internal Makefile variable, better unset
	local id=$INSTALL_DIR
	unset INSTALL_DIR
	pushdir $SRCDIR
	doLog 'install' ${MAKE_EXECUTABLE} prefix=${id} install
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
# bin/lz4
