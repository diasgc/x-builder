#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   +   .   .   .   .   .  shared
#  .   .   .   .   .   +   .   .   .   .   .  bin
# todo: control bin and doc builds (def. yes)
#
# use sudo apt install win-iconv-mingw-w64-dev for w64?
#
# PKGINFO-------------------------------------
lib='libiconv'
dsc='Character set conversion library'
lic='GPL'
src='https://git.savannah.gnu.org/git/libiconv.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='libiconv'

eta='90'
lsz=
psz=
ets=(90 0 0 0 0 60 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static"
cs1="--enable-shared"
cb0=
cb1=
CSH=
CBN=
# -----------------------------------------

. tcutils.sh

CFG=
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

vrs='1.16'
src="https://ftp.gnu.org/gnu/libiconv/libiconv-${vrs}.tar.gz"
sty='tgz'

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
	cat <<-EOF >>$PKGDIR/${pkg}.pc
		prefix=$INSTALL_DIR
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: iconv
		Description: ${dsc}
		URL: https://www.gnu.org/software/libiconv/
		Version: ${vrs}
		Libs: -L\${libdir} -liconv
		Cflags: -I\${includedir}
		EOF
}

start