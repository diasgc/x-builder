#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   V   F   F   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='turingcodec'
dsc='HEVC software encoder optimised for fast encoding of large resolution video content'
lic='GLP-2.0'
src='https://github.com/bbc/turingcodec.git'
sty='git'
cfg='cm'
pkg='libturing'

eta='1095'

. xbuilder.sh
CFG="-DUSE_SYSTEM_BOOST=OFF"
#CPPFLAGS="$CPPFLAGS -I$SRCDIR/havoc/ -I$SRCDIR/boost"
#CFLAGS="$CFLAGS -I$SRCDIR/havoc/ -I$SRCDIR/boost"
CXXFLAGS="$CXXFLAGS -I$SRCDIR/havoc/ -I$SRCDIR/boost"

source_patch(){
    pushdir $SRCDIR
    doLog 'checkout' git checkout stabley
    popdir
}

start