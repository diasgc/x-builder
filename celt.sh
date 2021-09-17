#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  f   f   f   f   +   +   f   f   f   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# system android not recognized; aarch64 not recognized
# HEADER-----------------------------------
lib='celt'
dsc='CELT is a low-delay audio codec'
lic='BSD 2-clause'
src='https://gitlab.xiph.org/xiph/celt.git'
sty='git'
cfg='ac'
tls=''
dep='ogg'
pkg='celt'

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
vrs="0.11.3"
src="http://downloads.xiph.org/releases/celt/celt-${vrs}.tar.gz"
sty='tgz'
CFG="--with-ogg=$LIBSDIR/ogg --with-pic"
dbld=$SRCDIR
loadToolchain
CC_FOR_BUILD=$CC
[[ $arch != x86_64-linux-gnu ]] && CFG="--host=${arch} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
_beforeBuild(){
  setPkgConfigDir $PKGDIR ogg
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start