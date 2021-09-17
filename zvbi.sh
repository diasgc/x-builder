#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='zvbi'
pkg='zvbi-0.2'
apt='libzvbi-dev'
apt="${pkg}-dev"
dsc='VBI Capturing and Decoding Library'
lic='BSD 2-clause'
#src='https://github.com/OpenDMM/zvbi.git'
#sty='git'
vrs='0-2-35'
src="https://github.com/OpenDMM/zvbi/archive/refs/tags/zvbi-${vrs}.tar.gz"
sty="tgz"
dep='libiconv'
cfg='ar'
eta='60'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --without-doxygen --disable-nls --without-libiconv-prefix"
CPPFLAGS="-Wno-string-plus-int -Wno-invalid-source-encoding -Wno-deprecated-declarations -Wno-tautological-pointer-compare"

start
