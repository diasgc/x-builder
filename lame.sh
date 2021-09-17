#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   +   .   +   .   .   .   .   .  static
#  +   .   .   +   .   +   .   .   .   .   .  shared
#  +   .   .   +   .   +   .   .   .   .   .  bin
# use src svn instead of tgz to avoid issues building shared/bin w64

lib='lame'
dsc='LAME is a high quality MPEG Audio Layer III (MP3) encoder'
lic='LGPL'
svn='https://svn.code.sf.net/p/lame/svn'
src="${svn}/trunk/lame"
sty='svn'
#src='https://github.com/despoa/LAME.git'
#sty='git'
cfg='ac'
dep='libiconv'
eta='180'
cb0="--disable-frontend"
cb1="--enable-frontend"

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-decoder --disable-debug"
[[ $arch = *mingw32* ]] && CFG="$CFG --enable-expopt=full"

vrs=$(svn log ${svn}/tags --limit 1 | grep 'tag' | sed "s/tag \(.*\) release/\1/")

# make shared executable so
$build_shared && $build_bin && CBN="--enable-dynamic-frontends"
mkf="-Wno-shift-negative-value -Wno-unused-variable"

build_patch_config(){
	#no docs
	sed -i '/^SUBDIRS/ {s/ doc//}' $SRCDIR/Makefile
}

build_pkgconfig_file(){
	cat <<-EOF >>$PKGDIR/$pkg.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: Lame
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L\${libdir} -lmp3lame
		Cflags: -I\${includedir}
		EOF
}

start


# Filelist
# --------

# include/lame/lame.h
# lib/pkgconfig/lame.pc
# lib/libmp3lame.so
# lib/libmp3lame.a
# lib/libmp3lame.la
