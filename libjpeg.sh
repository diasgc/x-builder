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

eta='52'
lsz=
psz=
ets=(52 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DENABLE_STATIC=ON"
cs1="-DENABLE_SHARED=ON"
cb0=
cb1=
CSH=
CBN=
# -----------------------------------------

CFG="-DWITH_JPEG8=ON -DWITH_JPEG7=ON"

# CMAKE DEFAULT FLAGS
# -DENABLE_SHARED:BOOL=ON
# -DENABLE_STATIC:BOOL=ON
# -DFLOATTEST:STRING=sse
# -DFORCE_INLINE:BOOL=ON
# -DREQUIRE_SIMD:BOOL=OFF
# -DWITH_12BIT:BOOL=OFF
# -DWITH_ARITH_DEC:BOOL=ON
# -DWITH_ARITH_ENC:BOOL=ON
# -DWITH_FUZZ:BOOL=OFF
# -DWITH_JAVA:BOOL=OFF
# -DWITH_JPEG7:BOOL=OFF
# -DWITH_JPEG8:BOOL=OFF
# -DWITH_MEM_SRCDST:BOOL=ON
# -DWITH_SIMD:BOOL=ON
# -DWITH_TURBOJPEG:BOOL=ON

extraOpts(){
  case $1 in
    --jpeg7) CFG="-DWITH_JPEG7=ON $CFG";;
    --jpeg8) CFG="-DWITH_JPEG8=ON $CFG";;
    --12bit) CFG="-DWITH_12BIT=ON $CFG";;
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