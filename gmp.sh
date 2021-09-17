#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86
#  .   .   .   .   .   .   .   .
#
# HEADER-----------------------------------
lib='gmp'
dsc='GNU Multiple Precision Arithmetic Library'
lic='LGPL-3.0 License'
src='https://gmplib.org/download/gmp/gmp-6.2.0.tar.lz'
sty='tlz'
cfg='ac'
tls=''
dep=''
pkg='gmp'

# STATS
eta='90'
lsz=1416
psz=2036

# FLAGS
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0

# enable main toolchain util
. tcutils.sh

CFG="--with-pic=1"
dbld=$SRCDIR

loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
test $arch = "*mingw32" && CFG="$CFG CC_FOR_BUILD=cc --enable-fat"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

buildSrc(){
  # fail to build config with hg clone 'https://gmplib.org/repo/gmp/'
  # fail to tarXZ 'https://ftp.gnu.org/gnu/gmp/gmp-6.2.0.tar.xz'
  getTarLZ $src $lib
}

start