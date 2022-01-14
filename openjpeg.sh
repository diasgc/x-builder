#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   +   .   F   .   .  static
#  +   .   .   .   .   .   +   .   F   .   .  shared
#  +   .   .   .   .   .   +   .   F   .   .  bin

lib='openjpeg'
apt='libopenjp2-7-dev'
pkg='libopenjp2'
dsc='JPEG2000 library'
lic='BSD-3c'
src='https://github.com/uclouvain/openjpeg.git'
cfg='cmake'
dep='lcms2 libtiff libpng'
eta='240'
cbk='BUILD_CODEC'

. xbuilder.sh
WFLAGS='-Wno-implicit-const-int-float-conversion'
#CFG="-DBUILD_MJ2=ON -DBUILD_JPWL=ON -DBUILD_JP3D=ON -DBUILD_JPIP=ON"
# DEFAULTS: -DBUILD_DOC=OFF -DBUILD_TESTING=OFF -DBUILD_LUTS_GENERATOR=OFF -DBUILD_CODEC=ON -DBUILD_JPIP=OFF -DBUILD_VIEWER=OFF -DBUILD_JAVA=OFF
# -DBUILD_PKGCONFIG_FILES=ON (unix)

start

# wa8: lld: error: unable to find library -ltiff

# Filelist
# --------
# include/openjpeg-2.5/opj_config.h
# include/openjpeg-2.5/opj_stdint.h
# include/openjpeg-2.5/openjpeg.h
# lib/pkgconfig/libopenjp2.pc
# lib/openjpeg-2.5/OpenJPEGConfig.cmake
# lib/openjpeg-2.5/OpenJPEGTargets.cmake
# lib/openjpeg-2.5/OpenJPEGTargets-release.cmake
# lib/libopenjp2.a
# lib/libopenjp2.so
# bin/opj_dump
# bin/opj_decompress
# bin/opj_compress