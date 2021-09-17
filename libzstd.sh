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
cst0="-DZSTD_BUILD_STATIC=OFF"
cst1="-DZSTD_BUILD_STATIC=ON"
csh0="-DZSTD_BUILD_SHARED=OFF"
csh1="-DZSTD_BUILD_SHARED=ON"
cb0="-DZSTD_BUILD_PROGRAMS=OFF"
cb1="-DZSTD_BUILD_PROGRAMS=ON"
cmake_path='lib/cmake/zstd'
# -----------------------------------------

. xbuilder.sh
#CFG="-DZSTD_BUILD_TESTS=OFF -DZSTD_BUILD_CONTRIB=OFF \
#  -DZSTD_LEGACY_SUPPORT=OFF -DZSTD_LZ4_SUPPORT=OFF \
#  -DZSTD_LZMA_SUPPORT=OFF -DZSTD_ZLIB_SUPPORT=OFF \
#  -DZSTD_PROGRAMS_LINK_SHARED=OFF \
#  -DZSTD_MULTITHREAD_SUPPORT=ON"
SRCDIR=$SRCDIR/build/cmake/
dbld=$SRCDIR/${arch}

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
