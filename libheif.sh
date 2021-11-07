#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   F   .   .   .   .   .  static
#  +   .   .   .   .   F   .   .   .   .   .  shared
#  +   .   .   .   +   F   .   .   .   .   .  bin

lib='libheif'
apt='libheif-dev'
dsc='HEIF and AVIF file format decoder and encoder'
lic='LGPL-3.0'
src='https://github.com/strukturag/libheif.git'
sty='git'
cfg='cmake'
dep='libpng libjpeg x265 libde265 aom'
eta='60'
f_win_posix=true

case $cfg in
  cmake) cbk="WITH_EXAMPLES" CFG="-DWITH_AOM=ON -DWITH_X265=ON -DWITH_DAV1D=OFF -DWITH_LIBDE265=ON -DWITH_RAV1E=OFF";;
  ag) cbk="examples" CFG="--disable-rav1e --disable-go --disable-gdk-pixbuf";;
esac

. xbuilder.sh

start

# Filelist
# --------

# include/libheif/heif_plugin.h
# include/libheif/heif_version.h
# include/libheif/heif_cxx.h
# include/libheif/heif.h
# share/man/man1/heif-info.1
# share/man/man1/heif-convert.1
# share/man/man1/heif-enc.1
# share/mime/packages/avif.xml
# share/mime/packages/heif.xml
# share/thumbnailers/heif.thumbnailer
# lib/libheif.so
# lib/cmake/libheif/libheif-config-version.cmake
# lib/cmake/libheif/libheif-config.cmake
# lib/cmake/libheif/libheif-config-release.cmake
# lib/pkgconfig/libheif.pc
# bin/heif-convert
# bin/heif-enc
# bin/heif-info
