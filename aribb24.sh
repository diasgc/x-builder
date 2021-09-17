#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='aribb24'
dsc='A library for ARIB STD-B24, decoding JIS 8 bit characters and parsing MPEG-TS stream'
lic='LGPL-3.0'
src='https://github.com/nkoriyama/aribb24.git'
sty='git'
cfg='ar'
tls=''
dep='libpng'
pkg='aribb24'

eta='10'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-shared --disable-static"
cb0=
cb1=
CSH=
CBN=
# -----------------------------------------
. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start