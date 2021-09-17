#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='sndfile'
dsc='A library for reading and writing audio files'
lic='LGPL-3.0'
src='https://github.com/erikd/libsndfile.git'
sty='git'
cfg='cm'
tls='python'
dep='ogg vorbis opus flac speex'
pkg='sndfile'

eta='78'
lsz=
psz=(5192)
ets=(32 0 0 0 0 0 0 0 0 0 0)
ls0=(4896 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_PROGRAMS=OFF"
cb1="-DBUILD_PROGRAMS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="-DENABLE_PACKAGE_CONFIG=ON -DBUILD_TESTING=OFF"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start