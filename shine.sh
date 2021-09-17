#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   +   .   .   .   .   .  shared
#  +   .   .   .   .   +   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='shine'
dsc='Super fast fixed-point MP3 encoder'
lic='GPL-2.0'
src='https://github.com/toots/shine.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='shine'

eta='51'
lsz=
psz=
ets=(28 0 0 0 0 11 0 0 0 0 0)
ls0=(156 0 0 0 0 185 0 0 0 0 0)
ls1=(105 0 0 0 0 8 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  pushd $SRCDIR >/dev/null
  doLog 'bootstrap' ./bootstrap
  popd >/dev/null
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start