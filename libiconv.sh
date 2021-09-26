#!/bin/bash

#     Aa8 Aa7 A86 A64
# NDK +++ +++ +++ +++ CLANG
# GNU  +   +   +   +  GCC
# WIN  F   F   +   +  CLANG/GCC

lib='libiconv'
dsc='Character set conversion library'
lic='LGPL2.1'
vrs='1.16'
#src='https://git.savannah.gnu.org/git/libiconv.git' sty='git'
src="https://ftp.gnu.org/gnu/libiconv/libiconv-${vrs}.tar.gz" sty='tgz'
cfg='ac'
eta='90'
pc_llib="-liconv"
pc_url="https://www.gnu.org/software/libiconv"

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT}"

# don't use git or it will dowload gnulib
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
