#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+  .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libilbc'
dsc='Internet Low Bitrate Codec (iLBC) library'
lic='BSD-3c'
src='https://github.com/TimothyGu/libilbc.git'
sty='git'
cfg='cm'
eta='20'
cbk="examples"

. xbuilder.sh

source_get(){
    doLog 'clone' git clone --depth=1 $src
    pushdir $SRCDIR
    doLog 'submod' git submodule update --init
    popdir
}

start

# Filelist
# --------
# include/ilbc.h
# include/ilbc_export.h
# share/doc/libilbc/CONTRIBUTING.md
# share/doc/libilbc/NEWS.md
# share/doc/libilbc/README.md
# lib/libilbc.so
# lib/pkgconfig/libilbc.pc
# bin/ilbc_test
