#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# TODO: ac build @ https://github.com/mirrorer/giflib
# CM: https://git.code.sf.net/u/dg0yt/giflib dg0yt-giflib
# PKGINFO-------------------------------------
lib='giflib'
dsc='Library for manipulating GIF files'
lic=''
src='https://git.code.sf.net/p/giflib/code'
sty='git'
cfg='cm'
tls=''
dep=''

eta='18'
lsz=
psz=

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh

CFG=
dbld=$SRCDIR/build_${arch}

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
	pushd $SRCDIR >/dev/null
	# some guy made this...
	wget https://sourceforge.net/p/giflib/feature-requests/6/attachment/CMakeLists.txt >/dev/null 2>&1
	#sed -i 's/PREFIX = \/usr\/local/PREFIX = ${INSTALL_DIR}/g' Makefile
	#sed -i 's/CFLAGS  = -std=gnu99 -fPIC -Wall -Wno-format-truncation $(OFLAGS)/CFLAGS  = -std=gnu99 -fPIC -fPIE -Wall $(OFLAGS)/g' Makefile
	sed -i 's/$(MAKE) -C doc/# $(MAKE) -C doc/g' Makefile
	sed -i 's/install: all install-bin install-include install-lib install-man/install: all install-bin install-include install-lib/g' Makefile
	popd >/dev/null
}

beforeBuild(){
	pushd $SRCDIR >/dev/null
	export vrs=$(./getversion)
	popd >/dev/null
}

buildPC(){
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