#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin
# todo: disable docs
# PKGINFO-------------------------------------
lib='kvazaar'
dsc='An open source C library for efficient image processing and image analysis operations'
lic='LGPL-2.1'
src='https://github.com/ultravideo/kvazaar.git'
sty='git'
cfg='ag'
tls=''
dep=''
pkg='kvazaar'

eta='70'
lsz=
psz=
ets=(37 0 0 0 0 51 0 0 0 0 0)
ls0=(2580 0 0 0 5455 0 0 0 0 0 0)
ls1=(1360 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG=""
dbld=$SRCDIR
loadToolchain
CFG="--host=${arch} --with-sysroot=${SYSROOT} --with-pic=1"

case $arch in
  x86_64-linux-gnu ) CFG="--with-pic=1";;
  *-android* ) lrt="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${arch}/librt.a"
    [ ! -f $lrt ] && $AR cr $lrt;;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start