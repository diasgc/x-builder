#!/bin/bash
# HEADER-----------------------------------
lib='exiv2'
dsc='Image metadata library and tools'
lic=''
src='https://github.com/Exiv2/exiv2.git'
sty='git'
cfg='cm'
tls=''
dep='expat libiconv libpng'
pkg='exiv2'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CSH=$cs0
CBN=$cb0
dbld=$SRCDIR/build_${arch}
CFG="-DINSTALL_EXAMPLES=OFF"
# END--------------------------------------

loadToolchain
CFG="-DEXIV2_ENABLE_DYNAMIC_RUNTIME=OFF \
	-DEXIV2_BUILD_SAMPLES=OFF \
	-DBUILD_TESTING=OFF \
	-DEXIV2_ENABLE_PRINTUCS2=OFF \
	-DEXIV2_ENABLE_PNG=ON \
	-DEXIV2_ENABLE_XMP=OFF
	-DEXPAT_INCLUDE_DIR=$LIBSDIR/expat/include \
	-DEXPAT_LIBRARY=$LIBSDIR/expat/lib/expat.a \
	-DIconv_INCLUDE_DIR=$LIBSDIR/libiconv/include \
	-DIconv_LIBRARY=$LIBSDIR/libiconv/lib/libiconv.a"


# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start