#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   F   +   +   .   +   +   .   .   +  static
#  +   +   F   +   +   .   +   +   .   .   +  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

# note: vorbis --shared build requires ogg --shared
# otherwise relocation errors may occur
lib='vorbis'
apt='libvorbis0a'
dsc='Ogg Vorbis audio format'
lic='BSD'
src='https://github.com/xiph/vorbis.git'
cfg='ag'
dep='ogg'
eta='42'
# LOADER --------------------------------------
. xbuilder.sh

case $cfg in
  cm|ccm|cmake|ccmake)
    CFG="-DBUILD_TESTING=OFF"
    ;;
  ac|ag|ar|autotools)
    [ ! -f "$SRCDIR/configure" ] && pushdir $SRCDIR && ./autogen.sh && popdir
    CFG="--disable-docs --disable-examples --disable-oggtest"
    ;;
esac

build_patch_config(){
  case $arch in
    *86-linux-android) sed -i 's| -mno-ieee-fp||g' $SRCDIR/lib/Makefile;;
  esac
  # No docs
  sed -i 's|SUBDIRS = m4 include vq lib test doc|SUBDIRS = m4 include vq lib test|' $SRCDIR/Makefile
}

start

# Filelist
# --------

# include/vorbis/vorbisfile.h
# include/vorbis/vorbisenc.h
# include/vorbis/codec.h
# lib/pkgconfig/vorbisfile.pc
# lib/pkgconfig/vorbisenc.pc
# lib/pkgconfig/vorbis.pc
# lib/libvorbisfile.so.3.3.8
# lib/libvorbisenc.a
# lib/libvorbisenc.la
# lib/libvorbis.so.0.4.9
# lib/libvorbisfile.a
# lib/libvorbisenc.so.2.0.12
# lib/libvorbis.a
# lib/libvorbisfile.la
# lib/libvorbis.la
# share/aclocal/vorbis.m4
