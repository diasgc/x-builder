#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libaec'
apt='libaec-dev'
dsc='Adaptive Entropy Coding library'
lic='BSD-s2c'
src='https://gitlab.dkrz.de/k202009/libaec.git'
sty='git'
cfg='cm'
eta='30'
cmake_path='cmake'

. xbuilder.sh

CFG="-DBUILD_TESTING=OFF"

# CMAKE DEFAULT OPTIONS
# -DAEC_FUZZING=OFF

build_pkgconfig_file(){
	cat <<-EOF >>$PKGDIR/${pkg}.pc
		prefix=$INSTALL_DIR
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: ${lib}
		Description: ${dsc}
		URL: https://gitlab.dkrz.de/k202009/libaec
		Version: ${vrs}
		Libs: -L\${libdir} -lsz -laec
		Cflags: -I\${includedir}
		EOF
}

start


# Filelist
# --------

# include/libaec.h
# include/szlib.h
# cmake/libaec-config-version.cmake
# cmake/libaec-config.cmake
# lib/libsz.a
# lib/libaec.so
# lib/libsz.so
# lib/libaec.a
# share/man/man1/aec.1
# bin/aec
