#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   .   .   .   .   .   .   .  static
#  +   +   .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

lib='libdeflate'
apt='libdeflate-dev'
dsc='Fast, whole-buffer DEFLATE-based compression and decompression'
lic='MIT'
src="https://github.com/ebiggers/libdeflate.git"
sty='git'
cfg='mk'
eta='10'

. xbuilder.sh

CGF="PREFIX=$INSTALL_DIR CC=$CC AR=$AR"
mki="PREFIX=$INSTALL_DIR install"
mkd_suffix="/usr/local"

build_pkgconfig_file(){
	cat <<-EOF >>$PKGDIR/${pkg}.pc
		prefix=$INSTALL_DIR
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: ${lib}
		Description: ${dsc}
		URL: https://github.com/ebiggers/libdeflate
		Version: ${vrs}
		Libs: -L\${libdir} -ldeflate
		Cflags: -I\${includedir}
		EOF
}
start

# Filelist
# --------

# include/libdeflate.h
# lib/pkgconfig/libdeflate.pc
# lib/libdeflate.so.0
# lib/libdeflate.a
# bin/libdeflate-gunzip
# bin/libdeflate-gzip
