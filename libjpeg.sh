#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libjpeg'
dsc='JPEG image codec that uses SIMD instructions'
lic='BSD'
src='https://github.com/libjpeg-turbo/libjpeg-turbo.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='libjpeg'

eta='90'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DENABLE_SHARED=OFF -DENABLE_STATIC=ON"
cs1="-DENABLE_SHARED=ON -DENABLE_STATIC=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

CFG="-DWITH_JPEG8=ON -DWITH_JPEG7=ON"
extraOpts(){
  case $1 in
    # -DWITH_12BIT Encode/decode JPEG images with 12-bit samples (implies WITH_ARITH_DEC=0 WITH_ARITH_ENC=0 WITH_JAVA=0 WITH_SIMD=0 WITH_TURBOJPEG
    --12bit) CFG="-DWITH_12BIT=ON";;
    * ) usage && exit;;
  esac
}

. tcutils.sh

dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start