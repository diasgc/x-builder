#!/bin/bash
# test-ok: win64 linux
# test-fail: android 'unrecognized machine aarch64-linux'
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='xavs'
dsc='High quality encoder and decoder of the Audio Video Standard of China (AVS)'
lic='GPL-2.0'
src='https://svn.code.sf.net/p/xavs/code/trunk'
sty='svn'
cfg='ac'
tls=''
dep=''
pkg='xavs'

eta='30'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0=
cs1="--enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--disable-asm --enable-pic"
dbld=$SRCDIR
loadToolchain
case $arch in
  arm-linux*|aarch64-linux* ) CFG="--host=arm-linux-gnu $CFG" ;;
  x86_64-linux* ) CFG="--host=x86_64-linux-gnu $CFG" ;;
  i686-linux* ) CFG="--host=i686-linux-gnu $CFG" ;;
  *-w64-mingw32 ) CFG="--host=${arch} $CFG" ;;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start