#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   +   .   .   .   .   .   .  shared
#  f   .   .   .   f   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='daala'
dsc='Research video codec'
lic='BSD-2c'
src='https://gitlab.xiph.org/xiph/daala.git'
sty='git'
cfg='ag'
tls=''
dep='ogg libpng'
pkg='daalaenc'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-tools"
cb1="--enable-tools"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR
loadToolchain
CFG="--with-pic=1 --disable-doc --disable-examples --disable-player --disable-unit-tests  --disable-encoder-check"
#[ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
test $CBN = $cb1 && dep+=" libjpeg"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start