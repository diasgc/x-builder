#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86
#  +   .   .   .   .   .   .   .
#
# HEADER-----------------------------------
lib='libvideogfx'
dsc='Rapid prototyping library for graphics and video processing.'
lic='LGPL-3.0'
src='https://github.com/farindk/libvideogfx.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='120'
pkg='libvideogfx'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared --with-pic=1"
cs1="--enable-static --enable-shared"
cb0=
cb1=
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG=
CSH=$cs0
CBN=$cb0
dbld=$SRCDIR
# END--------------------------------------

loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi
# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    doAutogen $SRCDIR
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start