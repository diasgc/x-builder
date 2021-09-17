#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# --------------------------------------------------
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin
# --------------------------------------------------

lib='libgav1'
apt='libgav1-dev'
dsc='Main profile (0) & High profile (1) compliant AV1 decoder'
lic='BSD'
src='https://chromium.googlesource.com/codecs/libgav1'
sty='git'
cfg='cm'
eta='88'
cmake_path='share/cmake'

. xbuilder.sh

source_patch(){
    pushdir $SRCDIR
    gitClone https://github.com/abseil/abseil-cpp.git third_party/abseil-cpp
    popdir
}

start

# Filelist
# --------

# include/gav1/decoder.h
# include/gav1/decoder_buffer.h
# include/gav1/status_code.h
# include/gav1/frame_buffer.h
# include/gav1/version.h
# include/gav1/symbol_visibility.h
# include/gav1/decoder_settings.h
# lib/pkgconfig/libgav1.pc
# lib/libgav1.so
# lib/libgav1.a
# share/cmake/libgav1-config.cmake
# bin/gav1_decode
