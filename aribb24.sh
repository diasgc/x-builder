#!/bin/bash
#             a8  a7  x86 x64
# ndk-clang   ++. ++. ++. ++.
# linux-gnu   ++. ++. ++. ++.
# mingw-llvm  ++. ++. ... ++.

lib='aribb24'
apt='libaribb24-dev'
dsc='A library for ARIB STD-B24, decoding JIS 8 bit characters and parsing MPEG-TS stream'
lic='LGPL-3.0'
src='https://github.com/nkoriyama/aribb24.git'
cfg='ar'
dep='libpng'
eta='10'
mki='install-strip'
mkc='distclean'

lst_inc='aribb24/parser.h aribb24/decoder.h aribb24/bits.h aribb24/aribb24.h'
lst_lib='libaribb24'

. xbuilder.sh

build_patch_config(){
    # to build shared libs on mingw
    $host_mingw && sed -i 's/\$(AM_LDFLAGS) \$(LDFLAGS)/& -no-undefined/g' $SRCDIR/Makefile || echo
}

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