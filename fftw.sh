#!/bin/bash
# HEADER-----------------------------------
lib='fftw'
dsc='Library for computing Fourier transforms (version 3.x)'
lic='GPL-3.0'
src='http://fftw.org/fftw-3.3.8.tar.gz'
sty='tgz'
cfg='cm'
tls=''
dep=''
eta='120'
pkg='fftw'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
dbld=$SRCDIR/build_${arch}
CFG=
# END--------------------------------------

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start