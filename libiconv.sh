#!/bin/bash

# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ CLANG
# GNU  +   +   +   +  GCC
# WIN +++ +++  +   +  CLANG/GCC

lib='libiconv'
dsc='Character set conversion library'
lic='LGPL2.1'
vrs='1.16'
#src='https://git.savannah.gnu.org/git/libiconv.git' sty='git'
src="https://ftp.gnu.org/gnu/libiconv/libiconv-${vrs}.tar.gz"
cfg='ac'
eta='90'
mki='install'
pc_llib="-liconv"
pc_url="https://www.gnu.org/software/libiconv"

. xbuilder.sh
CFG=" --enable-extra-encodings"
$build_static && CSH="--enable-static --disable-shared"
export RC=$WINDRES # for a*-w64-mingw32

# don't use git or it will download gnulib
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
