#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='speexdsp'
apt='libspeexdsp-dev'
dsc='Speexdsp is a speech processing library that goes along with the Speex codec'
lic='BSD'
src='https://github.com/xiph/speexdsp.git'
sty='git'
cfg='ag'
eta='91'

. xbuilder.sh

start

# Filelist
# --------

# include/speex/speexdsp_config_types.h
# include/speex/speex_echo.h
# include/speex/speexdsp_types.h
# include/speex/speex_preprocess.h
# include/speex/speex_resampler.h
# include/speex/speex_jitter.h
# lib/pkgconfig/speexdsp.pc
# lib/libspeexdsp.a
# lib/libspeexdsp.so
# lib/libspeexdsp.la
# share/doc/speexdsp/manual.pdf
