#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libgav1'
apt='libgav1-dev'
dsc='Main profile (0) & High profile (1) compliant AV1 decoder'
lic='BSD'
src='https://chromium.googlesource.com/codecs/libgav1'
cfg='cmake'
eta='88'

lst_inc='gav1/decoder.h
	gav1/decoder_buffer.h
	gav1/status_code.h
	gav1/frame_buffer.h
	gav1/version.h
	gav1/symbol_visibility.h
	gav1/decoder_settings.h'
lst_lib='libgav1'
lst_bin='gav1_decode'

. xbuilder.sh

source_config(){
    pushdir $SRCDIR
    git_clone https://github.com/abseil/abseil-cpp.git third_party/abseil-cpp
    popdir
}

start