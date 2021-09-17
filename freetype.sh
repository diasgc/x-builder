#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86 (static/shared)
#  .   .   .   .   +   .   ++  .
#
# HEADER-----------------------------------
lib='freetype'
dsc='A free, high-quality, and portable font engine.'
lic='BSD'
src='https://git.sv.nongnu.org/r/freetype/freetype2.git'
sty='git'
cfg='cm'
tls=''
dep='libpng zlib'
eta='60'
pkg='freetype2'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
# defaults
CSH=$cs0
CBN=$cb1
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="-DPNG_LIBRARY=$LIBSDIR/libpng/lib/libpng.a \
  -DPNG_PNG_INCLUDE_DIR=$LIBSDIR/libpng/include \
  -DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include \
  -DZLIB_LIBRARY_RELEASE=$LIBSDIR/zlib/lib/libz.a \
  -DFT_WITH_PNG=ON -DFT_WITH_ZLIB=ON"
dbld=$SRCDIR/build_${arch}
# END--------------------------------------

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"

buildPC(){
  cat <<-EOF >>$PKGDIR/$pkg.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: FreeType 2
		URL: https://freetype.org
		Description: ${dsc}
		Version: ${vrs}
		Requires:
    Requires.private: zlib, libpng
		Libs: -L\${libdir} -lfreetype
    Libs.private: 
		Cflags: -I\${includedir}/freetype2
		EOF
}

start