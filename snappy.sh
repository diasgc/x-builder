#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   +   .   .   .   .   .  shared
#  +   .   .   .   .   +   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='snappy'
dsc='Snappy is a compression/decompression library'
lic='Apache-2'
src='https://github.com/google/snappy.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='snappy'

eta='54'
lsz=
psz=
ets=(15 0 0 0 0 12 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(1510 0 0 0 0 0 332 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="-DSNAPPY_BUILD_TESTS=OFF"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
	cat <<-EOF >>$PKGDIR/${pkg}.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: Snappy
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L\${libdir} -lsnappy
		Cflags: -I\${includedir}
		EOF
}

start