#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='speex'
dsc='Speex is an audio codec tuned for speech'
lic='BSD'
src='https://github.com/xiph/speex.git'
cfg='ag'
dep='ogg speexdsp'
eta='39'
eta='51'
cbk="able-binaries"

. xbuilder.sh

start

# Filelist
# --------

# include/speex/speex_header.h
# include/speex/speex_callbacks.h
# include/speex/speex.h
# include/speex/speex_bits.h
# include/speex/speex_stereo.h
# include/speex/speex_config_types.h
# include/speex/speex_types.h
# lib/pkgconfig/speex.pc
# lib/libspeex.a
# lib/libspeex.la
# lib/libspeex.so
# share/man/man1/speexenc.1
# share/man/man1/speexdec.1
# share/doc/speex/manual.pdf
# share/aclocal/speex.m4
# bin/speexdec
# bin/speexenc
