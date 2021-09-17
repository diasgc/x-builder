#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='exiv2'
dsc='Image metadata library and tools'
lic=''
src='https://github.com/Exiv2/exiv2.git'
sty='git'
cfg='cm'
tls=''
dep='libiconv'
pkg='exiv2'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF -DEXIV2_ENABLE_DYNAMIC_RUNTIME=ON"
cs1="-DBUILD_SHARED_LIBS=ON -DEXIV2_ENABLE_DYNAMIC_RUNTIME=OFF"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# Options
xmp="OFF"
png="OFF"

extraOpts(){
  case $1 in
	--xmp ) [[ $arch != *ming32 ]] && xmp="ON" && dep="$dep expat";;
	--png ) png="ON";;
  esac
}

. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain --posix
case $arch in
	*mingw32 ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/toolschains/ubuntu1804-mingw64.cmake -DEXIV2_ENABLE_WIN_UNICODE=ON";;
	* ) CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake";;
esac
CFG="$CFG -DINSTALL_EXAMPLES=OFF \
	-DEXIV2_BUILD_DOC=OFF \
	-DEXIV2_BUILD_SAMPLES=OFF \
	-DBUILD_TESTING=OFF \
	-DEXIV2_TEAM_PACKAGING=ON \
	-DEXIV2_ENABLE_PNG=$png \
	-DEXIV2_ENABLE_XMP=$xmp \
	-DIconv_INCLUDE_DIR=$LIBSDIR/include \
	-DIconv_LIBRARY=$LIBSDIR/lib/libiconv.a"

[[ $xmp = "ON" ]] && CFG+="	-DEXPAT_INCLUDE_DIR=$LIBSDIR/include -DEXPAT_LIBRARY=$LIBSDIR/lib/expat.a"
[[ $arch = *mingw32* ]] && [[ $png = "ON" ]] && dep="$dep zlib" CFG+=" -DZLIB_INCLUDE_DIR=$LIBSDIR/include \
	-DZLIB_LIBRARY_RELEASE=$LIBSDIR/lib/libzlib.dll.a"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
	# update mingw toolchain to 9.3
	sed -i "s|7.3|9.3|g" $SRCDIR/cmake/toolschains/ubuntu1804-mingw64.cmake
	# hack for cross compile with mingw on ubuntu
	sed -i "s|AND NOT APPLE|AND NOT MINGW|" $SRCDIR/cmake/compilerFlags.cmake
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start