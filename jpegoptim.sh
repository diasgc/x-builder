#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='jpegoptim'
dsc='Utility to optimize/compress JPEG files'
lic='GPL-2'
src='https://github.com/tjko/jpegoptim.git'
sty='git'
cfg='ac'
tls=''
dep='libjpeg'
pkg='jpegoptim'

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

CFG="--with-pic=1 --with-libjpeg=$LIBSDIR"
dbld=$SRCDIR

loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start