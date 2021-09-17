#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='zvbi'
dsc='VBI Capturing and Decoding Library'
lic='BSD 2-clause'
src='git://git.opendreambox.org/git/zvbi.git'
sty='git'
cfg='ar'
tls=''
dep=''
pkg='zvbi-0.2'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

# -----------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CFG="--with-pic=1 --without-doxygen"
CSH=$cs0

# enable main toolchain util
. tcutils.sh
dbld=$SRCDIR
loadToolchain
[ "$arch" != "x86_64-linux-gnu" ] && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start