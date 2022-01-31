#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libgav1'
apt='libgav1-dev'
dsc='Main profile (0) & High profile (1) compliant AV1 decoder'
lic='BSD'
src='https://chromium.googlesource.com/codecs/libgav1.git'
cfg='cmake'
eta='88'

lst_inc='gav1/*.h'
lst_lib='libgav1.*'
lst_bin='gav1_decode'
lst_lic='LICENSE AUTHORS'
lst_pc=''

. xbuilder.sh

source_config(){
	git_clone https://github.com/abseil/abseil-cpp.git third_party/abseil-cpp
}

start