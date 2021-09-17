#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   +   .   +   .   .   .   .   .  static
#  +   .   .   +   .   +   .   .   .   .   .  shared
#  +   .   .   +   .   +   .   .   .   .   .  bin
# use src svn instead of tgz to avoid issues building shared/bin w64
# PKGINFO-------------------------------------
lib='lame'
dsc='LAME is a high quality MPEG Audio Layer III (MP3) encoder'
lic='LGPL'
svn='https://svn.code.sf.net/p/lame/svn'
src="${svn}/trunk/lame"
sty='svn'
cfg='ac'
tls='svn'
dep='libiconv'
pkg='lame'

eta='180'
lsz=
psz=
ets=(70 0 0 72 0 31 0 0 0 0 0)
ls0=(471 0 0 1032 0 0 0 0 0 0 0)
ls1=(342 0 0 0 0 . 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-frontend"
cb1="--enable-frontend"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="--with-libiconv-prefix=$LIBSDIR/libiconv --enable-decoder --disable-debug --with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
[[ $arch = *mingw32* ]] && CFG="$CFG --enable-expopt=full"

vrs=$(svn log ${svn}/tags --limit 1 | grep 'tag' | sed "s/tag \(.*\) release/\1/")

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
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