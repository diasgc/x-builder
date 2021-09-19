#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  P   .   .   +   .   .   .   .   .   .   .  static
#  P   +   +   +   .   .   .   .   .   .   .  shared

lib='fftw'
pkg='fftw3'
apt='fftw-dev'
dsc='Library for computing Fourier transforms (version 3.x)'
lic='GPL-3.0'
vrs='3.3.10'
src="http://fftw.org/fftw-${vrs}.tar.gz"
sty='tgz'
cfg='cm'
eta='120'
mkf="fftw3 fftw3_static"
CFG="-DBUILD_TESTS=OFF -DENABLE_THREADS=ON -DWITH_COMBINED_THREADS=ON"

extraOpts(){
  case $1 in
    -f|--float ) CFG+=" -DENABLE_FLOAT=ON" pkg='fftwf' pkgconfig_llib='-lfftwf';;
    -l|--long )  CFG+=" -DENABLE_LONG_DOUBLE=ON" pkg='fftwl' pkgconfig_llib='-lfftwl';;
    -q|--quad )  CFG+=" -DENABLE_QUAD_PRECISION=ON" pkg='fftwq' pkgconfig_llib=='-lfftwq';;
  esac
}

. xbuilder.sh

$host_arm || CFG+=" -DENABLE_SSE=ON -DENABLE_SSE2=ON -DENABLE_AVX=ON -DENABLE_AVX2=ON"

start


# Filelist
# --------
# include/fftw3.f
# include/fftw3.f03
# include/fftw3q.f03
# include/fftw3l.f03
# include/fftw3.h
# lib/pkgconfig/fftw3.pc
# lib/cmake/fftw3/FFTW3LibraryDepends.cmake
# lib/cmake/fftw3/FFTW3ConfigVersion.cmake
# lib/cmake/fftw3/FFTW3LibraryDepends-release.cmake
# lib/cmake/fftw3/FFTW3Config.cmake
# lib/libfftw3.so
