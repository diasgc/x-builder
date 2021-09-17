#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   +   .   .   .   .   .  shared
#  +   .   .   .   .   +   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='opencore-amr'
dsc='OpenCORE Adaptive Multi Rate (AMR) speech codec'
lic='Apache-2'
src='https://git.code.sf.net/p/opencore-amr/code'
sty='git'
cfg='ar'
tls=''
dep=''
pkg='opencore-amrnb'

eta='130'
lsz=
psz=
ets=(186 0 0 0 0 50 0 0 0 0 0)
ls0=(2100 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-examples"
cb1="--enable-examples"
CSH=$cs0
CBN=$cb0

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start