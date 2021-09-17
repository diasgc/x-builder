#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# test-ok: linux64
# test-fail: win64
# PKGINFO-------------------------------------
lib='libcaca'
dsc='Colour AsCii Art library'
lic='GPL'
src='https://github.com/cacalabs/libcaca.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='caca'

eta='80'
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
CFG="--disable-doc --disable-imlib2 --disable-cppunit --disable-slang --disable-x11 --disable-gl \
  --disable-cocoa --disable-csharp --disable-java --disable-ruby --disable-zzuf --disable-python \
  --disable-cxx --with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch !=  && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  pushd $SRCDIR >/dev/null
  doLog 'bootstrap' ./bootstrap
  popd >/dev/null
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start