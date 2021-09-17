#!/bin/bash
# test-ok: win64
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='xavs2'
dsc='An open-source encoder of AVS2-P2/IEEE1857.4 video coding standard'
lic='GPL-2.0'
src='https://github.com/pkuvcl/xavs2.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='xavs2'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-cli"
cb1="--enable-cli"
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1" 
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
AS=nasm

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start