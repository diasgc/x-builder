#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libbluray'
dsc='Library to access Blu-Ray disks'
lic='LGPL-2.1'
src='https://code.videolan.org/videolan/libbluray.git'
sty='git'
cfg='ar'
tls=''
dep='libxml2 freetype fontconfig'
pkg='libbluray'

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
CFG="--disable-bdjava-jar --disable-examples --with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

export FT2_CFLAGS="-I$LIBSDIR/freetype/include/freetype2" \
  FT2_LIBS="-L$LIBSDIR/freetype/lib -lfreetype" \
  FONTCONFIG_CFLAGS="-I$LIBSDIR/fontconfig/include" \
  FONTCONFIG_LIBS="-I$LIBSDIR/fontconfig/lib -lfontconfig"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start