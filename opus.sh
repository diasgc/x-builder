#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++  ++  ++  ++  clang
# GNU ++   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='opus'
dsc='Opus is a codec for interactive speech and audio transmission over the Internet'
lic='BSD'
src='https://github.com/xiph/opus.git'
cfg='ag'
dep='ogg'
eta='60'
cbk="able-extra-programs"
ac_nopic=true

lst_inc='opus/opus_projection.h
	opus/opus.h
	opus/opus_multistream.h
	opus/opus_types.h
	opus/opus_defines.h'
lst_lib='libopus'
lst_bin=''
CFG="--disable-doc"

. xbuilder.sh

start


# Filelist
# --------
# include/opus/opus_projection.h
# include/opus/opus.h
# include/opus/opus_multistream.h
# include/opus/opus_types.h
# include/opus/opus_defines.h
# lib/pkgconfig/opus.pc
# lib/libopus.la
# lib/libopus.a
# lib/libopus.so
# share/aclocal/opus.m4
