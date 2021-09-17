#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='guetzli'
dsc='Perceptual JPEG encoder'
lic='Apache-2.0'
src='https://github.com/google/guetzli.git'
sty='git'
cfg='mk'
tls=''
dep='libpng'
pkg='guetzli'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0

# enable main toolchain util
. tcutils.sh
dbld=$SRCDIR

loadToolchain

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
    $MAKE_EXECUTABLE $SRCDIR CC=$CC CXX=$CXX LD=$LD CFLAGS="-I$LIBSDIR/include"
}
# Use function buildPC to manually build pkg-config .pc file

start