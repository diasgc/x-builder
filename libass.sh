#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libass'
dsc='LibASS is an SSA/ASS subtitles rendering library'
lic='ISC'
src='https://github.com/libass/libass.git'
sty='git'
cfg='ag'
tls=''
dep='freetype fontconfig fribidi libpng harfbuzz'
pkg='libass'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

export FREETYPE_CFLAGS="-I$LIBSDIR/freetype/include" FREETYPE_LIBS="-L$LIBSDIR/freetype/lib" \
  FONTCONFIG_CFLAGS="-I$LIBSDIR/fontconfig/include" FONTCONFIG_LIBS="-L$LIBSDIR/fontconfig/lib" \
  FRIBIDI_CFLAGS="-I$LIBSDIR/fribidi/include" FRIBIDI_LIBS="-L$LIBSDIR/fribidi/lib" \
  HARFBUZZ_CFLAGS="-I$LIBSDIR/fribidi/include" HARFBUZZ_LIBS="-L$LIBSDIR/fribidi/lib" \
  LIBPNG_CFLAGS="-I$LIBSDIR/libpng/include" LIBPNG_LIBS="-L$LIBSDIR/libpng/lib"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start