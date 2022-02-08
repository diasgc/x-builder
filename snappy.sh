#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+  +   .   .   .   .   .   .   .   .   .  static
#  +   +   .   .   .   .   .   .   .   .   .  shared
#  -   +   .   .   .   .   .   .   .   .   .  bin

lib='snappy'
apt='libsnappy-dev'
dsc='Snappy is a compression/decompression library'
lic='BSD-3c'
src='https://github.com/google/snappy.git'
sty='git'
cfg='cm'
eta='12'
dep='lz4 lzo'

pc_llib='-lsnappy'

CFG="-DSNAPPY_BUILD_TESTS=OFF \
     -DSNAPPY_BUILD_BENCHMARKS=OFF"

lst_inc='snappy.h snappy-c.h snappy-stubs-public.h snappy-sinksource.h'
lst_pc='snappy.pc'
lst_lib='libsnappy'
lst_bin=''

. xbuilder.sh

source_patch(){
    # required vqtbl1q_u8 neon intrinsics is not defined in ARMv7
    # this patch disables SNAPPY_HAVE_NEON for arm
    sed -i "s/vst1q_u8/vqtbl1q_u8" CMakeLists.txt
}

start

# TODO
# dual static/shared

# Filelist
# --------
# include/snappy-stubs-public.h
# include/snappy-c.h
# include/snappy-sinksource.h
# include/snappy.h
# lib/pkgconfig/snappy.pc
# lib/cmake/Snappy/SnappyTargets.cmake
# lib/cmake/Snappy/SnappyConfigVersion.cmake
# lib/cmake/Snappy/SnappyConfig.cmake
# lib/cmake/Snappy/SnappyTargets-release.cmake
# lib/libsnappy.a
