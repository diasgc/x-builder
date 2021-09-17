#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='wavpack'
dsc='WavPack encode/decode library, command-line programs, and several plugins'
lic='BSD 3-clause'
src='https://github.com/dbry/WavPack.git'
sty='git'
cfg='ac'
tls=''
dep='libiconv'
pkg='wavpack'

eta='172'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-apps"
cb1="--enable-apps"
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--disable-tests --enable-rpath --disable-dsd --enable-legacy --with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
case $arch in aarch64*|arm*) CFG="$CFG --disable-asm";;esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start