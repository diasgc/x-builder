#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='opus'
dsc='Opus is a codec for interactive speech and audio transmission over the Internet'
lic='BSD'
src='https://github.com/xiph/opus.git'
sty='git'
cfg='ag'
dep='ogg'
pkg='opus'
eta='208'
cb0="--disable-extra-programs"
cb1="--enable-extra-programs"

. xbuilder.sh

case $build_tool in
  automake) [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
            CFG="--with-sysroot=${SYSROOT} --with-pic=1";;
esac

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
