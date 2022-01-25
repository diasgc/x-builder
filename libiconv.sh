#!/bin/bash

lib='libiconv'
dsc='Character set conversion library'
lic='LGPL2.1'
vrs='1.16' src="https://ftp.gnu.org/gnu/libiconv/libiconv-${vrs}.tar.gz"
#vrs='v1.16' src='https://git.savannah.gnu.org/git/libiconv.git'
#automake_cmd='./autogen.sh --skip-gnulib'
cfg='ac'
eta='90'
mki='install'
pc_llib="-liconv"
pc_url="https://www.gnu.org/software/libiconv"

lst_inc='iconv.h libcharset.h localcharset.h'
lst_lib='libiconv.* libcharset.*'
lst_bin='iconv'
lst_lic='COPYING COPYING.LIB AUTHORS'
lst_pc='libiconv.pc'

. xbuilder.sh

CFG=" --enable-extra-encodings"

# don't use git or it will download gnulib
_source_patch(){
	str_contains $src ".git" && {
		$dir_src/gitsub.sh pull; $dir_src/autogen.sh
	}
	return 0
}

build_patch_config(){
	#no docs
	sed -i '/cd man && $(MAKE)/d' $dir_src/Makefile
}

start

# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ CLANG
# GNU  +   +   +   +  GCC
# WIN +++ +++  +   +  CLANG/GCC

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
# share/doc/libiconv/COPYING.LIB
# share/doc/libiconv/AUTHORS
# share/doc/libiconv/COPYING
# bin/iconv
