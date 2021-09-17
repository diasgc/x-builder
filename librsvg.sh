#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# cannot autoreconf/autogen without gkt-doc from git
# requires cargo/rust
# PKGINFO-------------------------------------
lib='librsvg'
dsc='A small library to render Scalable Vector Graphics (SVG)'
lic='LGPL-2.1'
#src='https://gitlab.gnome.org/GNOME/librsvg.git'
#sty='git'
vrs='2.48.8'
src="http://ftp.gnome.org/pub/gnome/sources/librsvg/2.48/librsvg-${vrs}.tar.xz"
sty='txz'
cfg='ac'
tls=''
dep=''
pkg='librsvg'

eta='110'
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
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
export NOCONFIGURE=1

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start