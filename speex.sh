#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='speex'
apt='speex'
dsc='Speex is an audio codec tuned for speech'
lic='BSD'
src='https://github.com/xiph/speex.git'
sty='git'
cfg='ag'
dep='ogg speexdsp'
eta='39'
eta='51'
cb0="--disable-binaries"
cb1="--enable-binaries"

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

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
