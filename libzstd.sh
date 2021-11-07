#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU +..  .   .   .  gcc
# WIN +..  .   .   .  clang/gcc

lib='libzstd'
apt='libzstd-dev'
dsc='Zstandard - Fast real-time compression algorithm'
lic='BSD GPL-2.0'
src='https://github.com/facebook/zstd.git'
cfg='cmake'
eta='134'
cstk="ZSTD_BUILD_STATIC"
cshk="ZSTD_BUILD_SHARED"
cbk="ZSTD_BUILD_PROGRAMS"
dir_config='build/cmake'

. xbuilder.sh

nodev=false

#SRCDIR=$SRCDIR/build/cmake/

start

# Filelist
# --------
# include/zstd_errors.h
# include/zstd.h
# include/zdict.h
# lib/pkgconfig/libzstd.pc
# lib/libzstd.so
# lib/libzstd.a
# lib/cmake/zstd/zstdConfig.cmake
# lib/cmake/zstd/zstdTargets-release.cmake
# lib/cmake/zstd/zstdConfigVersion.cmake
# lib/cmake/zstd/zstdTargets.cmake
# share/man/man1/zstd.1
# share/man/man1/zstdless.1
# share/man/man1/zstdgrep.1
# bin/zstdgrep
# bin/zstd
# bin/zstdless
