#!/bin/bash
# ANDROID
# Aa8 Aa7 A86 A64
#  +   +   +   +  static
#  +   +   +   +  shared
#  -   -   -   -  bin
# LINUX
# Aa8 Aa7 A86 A64 
#  +   +   +   +  static
#  +   +   +   +  shared
#  -   -   -   -  bin
# WINDOWS
# Aa8 Aa7 A86 A64 
#  -   -   .   +  static
#  -   -   .   +  shared
#  -   -   -   -  bin

# HEADER ---------------
lib='aribb24'
apt='libaribb24-dev'
dsc='A library for ARIB STD-B24, decoding JIS 8 bit characters and parsing MPEG-TS stream'
lic='LGPL-3.0'
src='https://github.com/nkoriyama/aribb24.git'
sty='git'
cfg='ar'
tls=''
dep='libpng'
eta='10'

# LOADER ---------------
. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start

# Filelist
# --------

# include/aribb24/parser.h
# include/aribb24/decoder.h
# include/aribb24/bits.h
# include/aribb24/aribb24.h
# lib/pkgconfig/aribb24.pc
# lib/libaribb24.a
# lib/libaribb24.so.0.0.0
# lib/libaribb24.la
# share/doc/aribb24/README.md
# share/doc/aribb24/COPYING