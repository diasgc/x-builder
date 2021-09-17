#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86
#  +   .   .   +   .   .   .   .
#
# HEADER-----------------------------------
lib='fontconfig'
dsc=''
lic=''
src='https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
sty='git'
cfg='ac'
tls='gperf gettext autopoint'
dep='libiconv freetype expat json-c libpng zlib'
eta=''
pkg='fontconfig'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared --with-pic"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="--with-libiconv-prefix=$LIBSDIR/libiconv --with-expat=$LIBSDIR/expat \
    --without-libintl-prefix --disable-docs --disable-fast-install --disable-libxml2 --disable-rpath"
dbld=$SRCDIR
# END--------------------------------------

loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  doAutoreconf $SRCDIR
}
# Use function beforeBuild to execute extra code before buildLib
beforeBuild(){
  export FREETYPE_LIBS="-L$LIBSDIR/freetype/lib -lfreetype" FREETYPE_CFLAGS="-I$LIBSDIR/freetype/include/freetype2" \
    JSONC_LIBS="-L$LIBSDIR/json-c/lib -ljson-c" JSONC_CFLAGS="-I$LIBSDIR/json-c/include/json-c" \
    EXPAT_LIBS="-L$LIBSDIR/expat/lib -lexpat" EXPAT_CFLAGS="-I$LIBSDIR/expat/include"
  setPkgConfigDir $PKGDIR freetype expat json-c libpng zlib
  export LIBS="-lpng -lz"  
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start