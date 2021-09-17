#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86 v1.10.0
#  +   +   +   +   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='vpx'
dsc='WebM Project VPx codec implementation'
lic='GPL?'
src='https://chromium.googlesource.com/webm/libvpx'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='vpx'

eta='240'
lsz=
psz=
ets=(235 225 80 80 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static"
cs1="--enable-shared"
cb0=
cb1=
CSH=
CBN=

. tcutils.sh
CFG="--disable-docs --disable-install-srcs --disable-install-docs --disable-examples --disable-tools \
  --enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-vp9-temporal-denoising --enable-vp9-postproc \
  --enable-postproc --enable-onthefly-bitpacking --enable-multi-res-encoding --enable-better-hw-compatibility \
  --enable-webm-io --enable-libyuv --enable-experimental --enable-pic"
dbld=$SRCDIR
loadToolchain
case $arch in
  aarch64-linux-android ) CFG="--target=arm64-android-gcc $CFG";;
  arm-linux-androideabi ) CFG="--target=armv7-android-gcc $CFG --enable-neon --disable-neon-asm";;
  i686-linux-android )    CFG="--target=x86-android-gcc $CFG";;
  x86_64-linux-android )  CFG="--target=x86_64-android-gcc $CFG";;
  i686-w64-mingw32 )      CFG="--target=x86-win32-gcc --disable-unit-tests $CFG";;
  x86_64-w64-mingw32 )    CFG="--target=x86_64-win64-gcc --disable-unit-tests $CFG";;
  i686-linux-gnu )        CFG="--target=x86-linux-gcc $CFG";;
  x86_64-linux-gnu )      CFG="--target=x86_64-linux-gcc $CFG";;
  armv7-linux-gnu )       CFG="--target=armv7-linux-gcc $CFG";;
  aarch64-linux-gnu )     CFG="--target=arm64-linux-gcc $CFG";;
esac
export AS=nasm

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start