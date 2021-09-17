#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='giflib'
apt='libgif-dev'
dsc='Library for manipulating GIF files'
lic='free'
src='https://git.code.sf.net/p/giflib/code'
sty='git'
cfg='mk'
eta='18'

. xbuilder.sh

build_patch_config(){
	pushdir $SRCDIR
	# some guy made this...
	#wget https://sourceforge.net/p/giflib/feature-requests/6/attachment/CMakeLists.txt >/dev/null 2>&1
	sed -i 's/PREFIX = \/usr\/local/PREFIX = ${INSTALL_DIR}/g' Makefile
	sed -i 's/-Wno-format-truncation//g' Makefile
	sed -i 's/$(MAKE) -C doc//g' Makefile
	sed -i 's/install: all install-bin install-include install-lib install-man/install: all install-bin install-include install-lib/g' Makefile
	popdir
}

build_pkgconfig_file(){
	pushd $SRCDIR >/dev/null
	export vrs=$(./getversion)
	popd >/dev/null
	cat <<-EOF >>$PKGDIR/$pkg.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: giflib
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L\${libdir} -lgif
		Cflags: -I\${includedir}
		EOF
}

start

# Filelist
# --------

# include/gif_lib.h
# lib/libgif.a
# lib/libgif.so.7.2.0
# bin/giftext
# bin/giffix
# bin/giftool
# bin/gifclrmp
# bin/gif2rgb
# bin/gifbuild
