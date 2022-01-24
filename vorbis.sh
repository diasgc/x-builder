#!/bin/bash

lib='vorbis'
apt='libvorbis0a'
dsc='Ogg Vorbis audio format'
lic='BSD'
src='https://github.com/xiph/vorbis.git'
cfg='ag'
dep='ogg'
eta='42'

lst_inc='vorbis/*.h'
lst_lib='libvorbisfile.* libvorbisenc.* libvorbis.*'
lst_bin=''
lst_lic='COPYING AUTHORS'
lst_pc='vorbisfile.pc vorbisenc.pc vorbis.pc'

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

# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# note: vorbis --shared build requires ogg --shared
# otherwise relocation errors may occur
