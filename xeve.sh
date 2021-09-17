#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   +   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# cannot compile with clang throws -Werror,-Wunknown-warning-option
#
# PKGINFO--------------------------------
lib='xeve'
dsc='eXtra-fast Essential Video Encoder, MPEG-5 EVC (Essential Video Coding)'
lic='Other'
src='https://github.com/mpeg5/xeve.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='xeve'

eta=240
lsz=6150
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
# -----------------------------------------
cs0="-DXEVE_APP_STATIC_BUILD=ON"
cs1="-DXEVE_APP_STATIC_BUILD=OFF"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR/build_${arch}
CFG=""
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start