#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   .   .   .   .   .   .  static
#  +   .   .   .   +   .   .   .   .   .   .  shared
#  +   .   .   .   +   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libzstd'
apt='libzstd-dev'
dsc='Zstandard - Fast real-time compression algorithm'
lic='BSD/GPL-2.0'
src='https://github.com/facebook/zstd.git'
sty='git'
cfg='cm'
eta='134'
cstk="ZSTD_BUILD_STATIC"
cshk="ZSTD_BUILD_SHARED"
cbk="ZSTD_BUILD_PROGRAMS"
cmake_path='lib/cmake/zstd'

. xbuilder.sh

nodev=false

SRCDIR=$SRCDIR/build/cmake/

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
