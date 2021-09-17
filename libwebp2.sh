#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libwebp2'
dsc='WebP 2 is the successor of the WebP image format'
lic='TEST'
src='https://chromium.googlesource.com/codecs/libwebp2'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='libwebp2'

eta='120'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=
CBN=

. tcutils.sh
loadToolchain
dbld=$SRCDIR/build_${arch}
case $arch in
  *android*) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/android.cmake -DWP2_ANDROID_NDK_PATH=${ANDROID_NDK_HOME}";;
  *) CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake";;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start