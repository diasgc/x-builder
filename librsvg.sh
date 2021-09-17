#!/bin/bash
# cannot autoreconf/autogen without gkt-doc...
# HEADER-----------------------------------
lib='librsvg'
dsc='A small library to render Scalable Vector Graphics (SVG)'
lic='LGPL-2.1'
src='https://gitlab.gnome.org/GNOME/librsvg.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='librsvg'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared --with-pic=1"
cs1="--enable-static --enable-shared"
cb0="--disable-tools"
cb1="--enable-tools"
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG=""
CSH=$cs0
CBN=$cb0
dbld=$SRCDIR
# END--------------------------------------

loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  doAutoreconf $SRCDIR
}

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start