#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   f   f   f   .   .  static
#  F   .   .   .   +   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# system android not recognized; aarch64 not recognized
# HEADER-----------------------------------
lib='celt'
dsc='CELT is a low-delay audio codec'
lic='BSD 2-clause'
src='https://gitlab.xiph.org/xiph/celt.git'
sty='git'
cfg='ag'
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
CSH=
CBN=
# -----------------------------------------

. tcutils.sh
CFG="--enable-experimental-postfilter --enable-float-approx --enable-fixed-point --enable-custom-modes --with-pic"
dbld=$SRCDIR
loadToolchain
[[ $arch != x86_64-linux-gnu ]] && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  sed -i 's|XIPH_PATH_OGG|#XIPH_PATH_OGG|g' $SRCDIR/configure
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start