#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  F   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='openmpt'
dsc='a library to render tracker music'
lic='BSD-3c'
src='https://github.com/OpenMPT/openmpt.git'
cfg='ac'
dep='ogg vorbis flac sndfile'
eta='0'
dir_config="build/autotools"
#mkc=
CFG='--without-mpg123  --without-portaudio --without-portaudiocpp --without-pulseaudio --without-sdl2 --disable-tests'
#cshk=''
#cstk=''
cbk='able-examples'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

source_config(){
    cd $SRCDIR/build/autotools
    autoreconf -fi 2>&1 >/dev/null
    cd $SRCDIR
}

start