#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='fftw'
dsc='Library for computing Fourier transforms (version 3.x)'
lic='GPL-3.0'
vrs='3.3.8'
src="http://fftw.org/fftw-${vrs}.tar.gz"
sty='tgz'
cfg='cm'
tls=''
dep=''
pkg='fftw'

eta='120'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------
CFG="-DBUILD_TESTS=ON -DENABLE_OPENMP=ON -DENABLE_THREADS=ON -DWITH_COMBINED_THREADS=ON"

extraOpts(){
  case $1 in
    -f|--float ) CFG+=" -DENABLE_FLOAT=ON" pkg='fftwf' lib1='fftwf';;
    -l|--long )  CFG+=" -DENABLE_LONG_DOUBLE=ON" pkg='fftwl' lib1='fftwl';;
    -q|--quad )  CFG+=" -DENABLE_QUAD_PRECISION=ON" pkg='fftwq' lib1=='fftwq';;
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