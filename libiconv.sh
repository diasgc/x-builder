#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   +   .   .   .   .   .  static
#  +   +   +   +   .   +   .   .   .   .   .  shared
#  +   +   +   +   .   +   .   .   .   .   .  bin

lib='libiconv'
apt=''
dsc='Character set conversion library'
lic='GPL'
vrs='1.16'
#src='https://git.savannah.gnu.org/git/libiconv.git'
#sty='git'
src="https://ftp.gnu.org/gnu/libiconv/libiconv-${vrs}.tar.gz"
sty='tgz'
cfg='ac'
eta='90'
pkgconfig_llib="-liconv"
pkgconfig_url="https://www.gnu.org/software/libiconv"

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT}"

source_patch(){
	if [ $sty = 'git' ];then
		$SRCDIR/gitsub.sh pull
		$SRCDIR/autogen.sh
	fi
}

build_patch_config(){
	#no docs
	sed -i '/cd man && $(MAKE)/d' $SRCDIR/Makefile
}

start

# Filelist
# --------

# include/iconv.h
# include/libcharset.h
# include/localcharset.h
# lib/libcharset.so
# lib/pkgconfig/libiconv.pc
# lib/libiconv.so
# lib/libcharset.a
# lib/libcharset.la
# lib/libiconv.a
# lib/libiconv.la
# bin/iconv
