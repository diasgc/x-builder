#!/bin/bash
# HEADER-----------------------------------
lib='avisynth'
dsc='A powerful nonlinear scripting language for video'
lic='BSD'
src='https://github.com/AviSynth/AviSynthPlus.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='240'
pkg='avisynth'
lsz=6150
# -----------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=

. tcutils.sh
CFG="-DENABLE_PLUGINS=OFF"
CSH=$cs0
CBN=
dbld=$SRCDIR/build_${arch}

loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

start