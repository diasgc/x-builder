#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86 v1.10.0
#  +   +   +   +   .   .   .   .   .   .   .  static
#  X   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='vpx'
dsc='WebM Project VPx codec implementation'
lic='GPL?'
src='https://chromium.googlesource.com/webm/libvpx'
sty='git'
cfg='ac'
eta='240'
csh1=' ' # disable shared

. xbuilder.sh

BUILD_DIR=$SOURCES/${lib}_${arch}

CFG="--disable-docs --disable-install-srcs --disable-install-docs --disable-examples --disable-tools \
  --enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-vp9-temporal-denoising --enable-vp9-postproc \
  --enable-postproc --enable-onthefly-bitpacking --enable-multi-res-encoding --enable-better-hw-compatibility \
  --enable-webm-io --enable-libyuv --enable-experimental --enable-pic"

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
export AS=$YASM

build_config(){
  pushdir $BUILD_DIR
  doLog 'configure' ${SRCDIR}/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  popdir
}
start

# Filelist
# --------
# include/vpx/vpx_ext_ratectrl.h
# include/vpx/vpx_frame_buffer.h
# include/vpx/vpx_integer.h
# include/vpx/vpx_decoder.h
# include/vpx/vpx_image.h
# include/vpx/vp8cx.h
# include/vpx/vpx_codec.h
# include/vpx/vpx_encoder.h
# include/vpx/vp8.h
# include/vpx/vp8dx.h
# lib/pkgconfig/vpx.pc
# lib/libvpx.a
