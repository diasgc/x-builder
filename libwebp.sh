#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libwebp'
apt='webp'
dsc='Library to encode and decode images in WebP format'
lic='BSD'
src='https://chromium.googlesource.com/webm/libwebp'
sty='git'
cfg='ar'
eta='70'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start

# Filelist
# --------

# include/webp/types.h
# include/webp/decode.h
# include/webp/demux.h
# include/webp/mux_types.h
# include/webp/mux.h
# include/webp/encode.h
# lib/pkgconfig/libwebp.pc
# lib/pkgconfig/libwebpmux.pc
# lib/pkgconfig/libwebpdemux.pc
# lib/libwebpdemux.a
# lib/libwebp.so
# lib/libwebp.a
# lib/libwebpmux.la
# lib/libwebpdemux.so
# lib/libwebpdemux.la
# lib/libwebpmux.so
# lib/libwebp.la
# lib/libwebpmux.a
# share/man/man1/cwebp.1
# share/man/man1/webpmux.1
# share/man/man1/img2webp.1
# share/man/man1/dwebp.1
# share/man/man1/webpinfo.1
# bin/webpinfo
# bin/cwebp
# bin/webpmux
# bin/img2webp
# bin/dwebp
