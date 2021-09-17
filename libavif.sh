#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin
# test-fail: win64/mingw (avifdec.c:60:42: error: unknown conversion type character ‘z’ in format)
# test-ok: linux
# PKGINFO-------------------------------------
lib='libavif'
dsc='Library for encoding and decoding .avif files'
lic='BSD?'
src='https://github.com/AOMediaCodec/libavif.git'
sty='git'
cfg='cm'
tls=''
dep='aom libjpeg libpng'
pkg='libavif'

eta='30'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DAVIF_BUILD_APPS=OFF"
cb1="-DAVIF_BUILD_APPS=ON"
CSH=
CBN=
# -----------------------------------------

. tcutils.sh
case $arch in
	*linux*) CFG="-DAVIF_BUILD_EXAMPLES=OFF -DAVIF_BUILD_TESTS=OFF -DAVIF_CODEC_AOM=ON \
		-DAOM_INCLUDE_DIR=$LIBSDIR/include -DAOM_LIBRARY=$LIBSDIR/lib/libaom.a \
		-DPNG_PNG_INCLUDE_DIR=$LIBSDIR/include -DPNG_LIBRARY=$LIBSDIR/lib/libpng.a \
		-DJPEG_INCLUDE_DIR=$LIBSDIR/include -DJPEG_LIBRARY=$LIBSDIR/lib/libjpeg.a"
		;;
	*mingw32*) CFG="-DAVIF_BUILD_EXAMPLES=OFF -DAVIF_BUILD_TESTS=OFF -DAVIF_CODEC_AOM=ON \
		-DAOM_INCLUDE_DIR=$LIBSDIR/include -DAOM_LIBRARY=$LIBSDIR/lib/libaom.a \
		-DPNG_PNG_INCLUDE_DIR=$LIBSDIR/include -DPNG_LIBRARY=$LIBSDIR/lib/libpng.a \
		-DJPEG_INCLUDE_DIR=$LIBSDIR/include -DJPEG_LIBRARY=$LIBSDIR/lib/libjpeg.a \
		-DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include -DZLIB_LIBRARY=$LIBSDIR/zlib/lib/libzlib.dll.a"
		;;
esac

dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  # patch: must rearrange the order of libraries in CMakeLists.txt
  sed -i 's|${ZLIB_LIBRARY} ${PNG_LIBRARY} ${JPEG_LIBRARY}|${PNG_LIBRARY} ${JPEG_LIBRARY} ${ZLIB_LIBRARY}|g' $SRCDIR/CMakeLists.txt
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start