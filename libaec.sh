#!/bin/bash

lib='libaec'
apt='libaec-dev'
dsc='Adaptive Entropy Coding library'
lic='BSD-s2c'
src='https://gitlab.dkrz.de/k202009/libaec.git'
cfg='cmake'
eta='30'
pc_llib='-lsz -laec'

lst_inc='libaec.h szlib.h'
lst_lib='libsz.* libaec.*'
lst_bin='aec'
lst_lic='LICENSE.txt AUTHORS'
lst_pc='libaec.pc libsz.pc'

. xbuilder.sh

CFG="-DBUILD_TESTING=OFF"

start

# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

