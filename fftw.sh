#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='fftw'
apt='fftw-dev'
dsc='Library for computing Fourier transforms (version 3.x)'
lic='GPL-3.0'
vrs='3.3.8'
src="http://fftw.org/fftw-${vrs}.tar.gz"
sty='tgz'
cfg='cm'
eta='120'

#CFG="-DBUILD_TESTS=ON -DENABLE_OPENMP=ON -DENABLE_THREADS=ON -DWITH_COMBINED_THREADS=ON"

extraOpts(){
  case $1 in
    -f|--float ) CFG+=" -DENABLE_FLOAT=ON" pkg='fftwf' lib1='fftwf';;
    -l|--long )  CFG+=" -DENABLE_LONG_DOUBLE=ON" pkg='fftwl' lib1='fftwl';;
    -q|--quad )  CFG+=" -DENABLE_QUAD_PRECISION=ON" pkg='fftwq' lib1=='fftwq';;
  esac
}

. xbuilder.sh

start

# Filelist
# --------

# include/fftw3.f
# include/fftw3.f03
# include/fftw3q.f03
# include/fftw3l.f03
# include/fftw3.h
# lib/pkgconfig/fftw.pc
# lib/cmake/fftw3/FFTW3LibraryDepends.cmake
# lib/cmake/fftw3/FFTW3ConfigVersion.cmake
# lib/cmake/fftw3/FFTW3LibraryDepends-release.cmake
# lib/cmake/fftw3/FFTW3Config.cmake
# lib/libfftw3.so
