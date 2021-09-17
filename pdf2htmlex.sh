#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# 
# 
# PKGINFO--------------------------------
lib='pdf2htmlex'
dsc='Convert PDF to HTML without losing text or format'
lic='GPL-3'
src='https://github.com/pdf2htmlEX/pdf2htmlEX.git'
sty='git'
cfg='cm'
tls=''
dep='poppler fontforge cairo libintl libjpeg libpng freetype fontconfig xml2 glib2.0 libgio pthread'
pkg='pdf2htmlex'

eta=240
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
# -----------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DENABLE_PLUGINS=OFF"
cb1="-DENABLE_PLUGINS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
SRCDIR=$SRCDIR/pdf2htmlEX
dbld=$SRCDIR/build_${arch}
loadToolchain
ndkPatchLpthread
[[ $arch = *mingw32 ]] && posix="-posix"
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}${posix}.cmake -DHEADERS_ONLY=OFF -Wno-dev"
#-Wno-inconsistent-missing-override 

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start