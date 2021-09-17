#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='exiv2'
dsc='Image metadata library and tools'
lic=''
src='https://github.com/Exiv2/exiv2.git'
sty='git'
cfg='cm'
dep='libiconv'
eta='60'
f_win_posix=true
# Options
xmp="OFF"
png="OFF"

extraOpts(){
  case $1 in
	--xmp ) [[ $arch != *ming32 ]] && xmp="ON" && dep_add "expat";;
	--png ) png="ON" dep_add "libpng";;
  esac
}

. xbuilder.sh

! $build_shared && CFG="-DEXIV2_ENABLE_DYNAMIC_RUNTIME=OFF" || CFG="-DEXIV2_ENABLE_DYNAMIC_RUNTIME=ON"

case $arch in
	*mingw32 ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/toolschains/ubuntu1804-mingw64.cmake -DEXIV2_ENABLE_WIN_UNICODE=ON";;
esac

CFG="$CFG -DINSTALL_EXAMPLES=OFF \
	-DEXIV2_BUILD_DOC=OFF \
	-DEXIV2_BUILD_SAMPLES=OFF \
	-DBUILD_TESTING=OFF \
	-DEXIV2_TEAM_PACKAGING=ON \
	-DEXIV2_ENABLE_PNG=$png \
	-DEXIV2_ENABLE_XMP=$xmp"

# [[ "$xmp" == "ON" ]] && CFG+="	-DEXPAT_INCLUDE_DIR=$LIBSDIR/include -DEXPAT_LIBRARY=$LIBSDIR/lib/expat.a"
[[ "$arch" == *"mingw32" ]] && [[ "$png" == "ON" ]] && dep="$dep zlib" CFG="$CFG -DZLIB_INCLUDE_DIR=$LIBSDIR/include \
	-DZLIB_LIBRARY_RELEASE=$LIBSDIR/lib/libzlib.dll.a"

source_patch(){
	# update mingw toolchain to <xv_x64_mingw> in .config
	sed -i "s|7.3|${xv_x64_mingw}|g" $SRCDIR/cmake/toolschains/ubuntu1804-mingw64.cmake
	# hack for cross compile with mingw on ubuntu
	sed -i "s|AND NOT APPLE|AND NOT MINGW|" $SRCDIR/cmake/compilerFlags.cmake
}

start

# Filelist
# --------
# releasenotes.txt
# include/exiv2/xmpsidecar.hpp
# include/exiv2/psdimage.hpp
# include/exiv2/bmffimage.hpp
# include/exiv2/epsimage.hpp
# include/exiv2/jpgimage.hpp
# include/exiv2/value.hpp
# include/exiv2/pngimage.hpp
# include/exiv2/rafimage.hpp
# include/exiv2/pgfimage.hpp
# include/exiv2/mrwimage.hpp
# include/exiv2/iptc.hpp
# include/exiv2/tags.hpp
# include/exiv2/ini.hpp
# include/exiv2/config.h
# include/exiv2/image.hpp
# include/exiv2/datasets.hpp
# include/exiv2/cr2image.hpp
# include/exiv2/webpimage.hpp
# include/exiv2/exif.hpp
# include/exiv2/futils.hpp
# include/exiv2/preview.hpp
# include/exiv2/error.hpp
# include/exiv2/easyaccess.hpp
# include/exiv2/exv_conf.h
# include/exiv2/exiv2lib_export.h
# include/exiv2/http.hpp
# include/exiv2/orfimage.hpp
# include/exiv2/basicio.hpp
# include/exiv2/crwimage.hpp
# include/exiv2/tiffimage.hpp
# include/exiv2/gifimage.hpp
# include/exiv2/rw2image.hpp
# include/exiv2/bmpimage.hpp
# include/exiv2/convert.hpp
# include/exiv2/tgaimage.hpp
# include/exiv2/jp2image.hpp
# include/exiv2/slice.hpp
# include/exiv2/metadatum.hpp
# include/exiv2/exiv2.hpp
# include/exiv2/xmp_exiv2.hpp
# include/exiv2/types.hpp
# include/exiv2/version.hpp
# include/exiv2/properties.hpp
# ReadMe.txt
# README.md
# lib/pkgconfig/exiv2.pc
# lib/cmake/exiv2/exiv2ConfigVersion.cmake
# lib/cmake/exiv2/exiv2Config.cmake
# lib/cmake/exiv2/exiv2Config-release.cmake
# lib/libexiv2.so
# lib/libexiv2-xmp.a
# README-CONAN.md
# share/man/man1/exiv2.1
# README-SAMPLES.md
# samples/exifprint.cpp
# bin/exiv2
# COPYING
# exiv2.png
