#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   F   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='postfish'
dsc='A digital audio post-processing, restoration, filtering and mixdown tool.'
lic='GPL-2'
src='https://gitlab.xiph.org/xiph/postfish.git'
sty='git'
cfg='mk'
tls='libgtk2.0-dev libfftw3-bin'
dep='libao fftw'
pkg='postfish'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR
loadToolchain
CFG="CC=$CC LD=$CC PREFIX=$INSTALL_DIR"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  sed -i 's|gtk+-2.0 ao|gtk+-2.0 ao fftw|' $SRCDIR/Makefile
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start