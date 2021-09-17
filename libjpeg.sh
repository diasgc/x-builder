#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   +   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libjpeg'
dsc='JPEG image codec that uses SIMD instructions'
lic='BSD'
src='https://github.com/libjpeg-turbo/libjpeg-turbo.git'
sty='git'
cfg='cm'
eta='52'
cst0="-DENABLE_STATIC=OFF"
cst1="-DENABLE_STATIC=ON"
csh0="-DENABLE_SHARED=OFF"
csh1="-DENABLE_SHARED=ON"
cmake_path='lib/cmake/libjpeg-turbo'
# -----------------------------------------
CFG="-DWITH_JPEG8=ON -DWITH_JPEG7=ON"

extraOpts(){
  case $1 in
    --jpeg7) CFG="-DWITH_JPEG7=ON $CFG";;
    --jpeg8) CFG="-DWITH_JPEG8=ON $CFG";;
    --12bit) CFG="-DWITH_12BIT=ON $CFG";;
  esac
}

. xbuilder.sh

build_patch_config(){
	#no docs
	sed -i '/^SUBDIRS/ {s/ doc//}' $BUILD_DIR/Makefile
}

start

# Filelist
# --------

# include/jerror.h
# include/jconfig.h
# include/jpeglib.h
# include/jmorecfg.h
# include/turbojpeg.h
# lib/pkgconfig/libjpeg.pc
# lib/pkgconfig/libturbojpeg.pc
# lib/libturbojpeg.a
# lib/cmake/libjpeg-turbo/libjpeg-turboTargets-release.cmake
# lib/cmake/libjpeg-turbo/libjpeg-turboConfig.cmake
# lib/cmake/libjpeg-turbo/libjpeg-turboConfigVersion.cmake
# lib/cmake/libjpeg-turbo/libjpeg-turboTargets.cmake
# lib/libjpeg.so
# lib/libturbojpeg.so
# lib/libjpeg.a
# share/man/man1/djpeg.1
# share/man/man1/wrjpgcom.1
# share/man/man1/rdjpgcom.1
# share/man/man1/jpegtran.1
# share/man/man1/cjpeg.1
# share/doc/libjpeg-turbo/libjpeg.txt
# share/doc/libjpeg-turbo/tjexample.c
# share/doc/libjpeg-turbo/README.md
# share/doc/libjpeg-turbo/example.txt
# share/doc/libjpeg-turbo/usage.txt
# share/doc/libjpeg-turbo/README.ijg
# share/doc/libjpeg-turbo/wizard.txt
# share/doc/libjpeg-turbo/structure.txt
# share/doc/libjpeg-turbo/LICENSE.md
# bin/rdjpgcom
# bin/jpegtran
# bin/wrjpgcom
# bin/djpeg
# bin/tjbench
# bin/cjpeg
