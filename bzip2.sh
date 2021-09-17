#!/bin/bash

lib='bzip2'
dsc='Lossless, block-sorting data compression'
lic='Other'
src='https://gitlab.com/bzip2/bzip2.git'
sty='git'
cfg='cm'
eta='20'
cstk="ENABLE_STATIC_LIB"
cshk="ENABLE_SHARED_LIB"
cbk="ENABLE_APP"
CFG="-DENABLE_EXAMPLES=OFF -DENABLE_DOCS=OFF"

. xbuilder.sh

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   .   .   .   .   .   .   .  static
#  +   +   .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

# Filelist
# --------
# include/bzlib.h
# man/man1/bzmore.1
# man/man1/bzip2.1
# man/man1/bzgrep.1
# man/man1/bzdiff.1
# lib/pkgconfig/bzip2.pc
# lib/libbz2.so
# lib/libbz2_static.a
# bin/bzgrep
# bin/bzdiff
# bin/bzip2recover
# bin/bzmore
# bin/bzip2
