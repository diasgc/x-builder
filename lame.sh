#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   +   .   +   .   .   .   .   .  static
#  +   .   .   +   .   +   .   .   .   .   .  shared
#  +   .   .   +   .   +   .   .   .   .   .  bin
# use src svn instead of tgz to avoid issues building shared/bin w64

lib='lame'
dsc='LAME is a high quality MPEG Audio Layer III (MP3) encoder'
lic='LGPL'
svn='https://svn.code.sf.net/p/lame/svn' #sty='svn'
src="${svn}/trunk/lame" #src='https://github.com/despoa/LAME.git'
cfg='ac'
dep='libiconv'
eta='180'
mki='install-strip'
mkc='distclean'
cbk="able-frontend"
pc_llib="-lmp3lame"
API=26 # required for frontends build

. xbuilder.sh

# update latest version
vrs=$(svn log ${svn}/tags --limit 1 | grep 'tag' | sed "s/tag \(.*\) release/\1/")

CFG="--disable-gtktest --disable-decoder --disable-debug"
$host_mingw && CFG+=" --enable-expopt=full"
# make shared executable so
$build_shared && $build_bin && CBN="--enable-dynamic-frontends"
[ "$host_os" == "android" ] && [ $API -lt 26 ] && unset CBN

build_patch_config(){
	#no docs
	sed -i '/^SUBDIRS/ {s/ doc//}' $SRCDIR/Makefile
}

start


# Filelist
# --------
# include/lame/lame.h
# lib/pkgconfig/lame.pc
# lib/libmp3lame.so
# lib/libmp3lame.a
# lib/libmp3lame.la