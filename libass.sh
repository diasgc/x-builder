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
dep='freetype fontconfig fribidi libpng harfbuzz'
pkg='libass'
eta='60'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

# export FREETYPE_CFLAGS="-I$LIBSDIR/freetype/include" FREETYPE_LIBS="-L$LIBSDIR/freetype/lib" \
#  FONTCONFIG_CFLAGS="-I$LIBSDIR/fontconfig/include" FONTCONFIG_LIBS="-L$LIBSDIR/fontconfig/lib" \
#  FRIBIDI_CFLAGS="-I$LIBSDIR/fribidi/include" FRIBIDI_LIBS="-L$LIBSDIR/fribidi/lib" \
#  HARFBUZZ_CFLAGS="-I$LIBSDIR/fribidi/include" HARFBUZZ_LIBS="-L$LIBSDIR/fribidi/lib" \
#  LIBPNG_CFLAGS="-I$LIBSDIR/libpng/include" LIBPNG_LIBS="-L$LIBSDIR/libpng/lib"

start