#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='freetype'
dsc='A free, high-quality, and portable font engine.'
lic='BSD'
src='https://git.sv.nongnu.org/r/freetype/freetype2.git'
sty='git'
cfg='cm'
tls=''
dep='libpng'
pkg='freetype2'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="-DPNG_LIBRARY=$LIBSDIR/libpng/lib/libpng.a \
  -DPNG_PNG_INCLUDE_DIR=$LIBSDIR/libpng/include \
  -DFT_WITH_PNG=ON -DFT_WITH_ZLIB=ON"
  #-DZLIB_INCLUDE_DIR=$LIBSDIR/include \
  #-DZLIB_LIBRARY_RELEASE=$LIBSDIR/lib/libz.a \
dbld=$SRCDIR/build_${arch}

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