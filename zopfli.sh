#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+  .   .   .   .   .   .   .   .   .   .  static
# +/-   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='zopfli'
dsc='Zopfli Compression Algorithm is a compression library programmed in C to perform very good, but slow, deflate or zlib compression.'
lic='Apache-2.0'
src='https://github.com/google/zopfli.git'
sty='git'
cfg='cm'
eta='20'
cmake_path='lib/cmake/Zopfli'
pkgconfig_llib="-lzopflipng -lzopfli"
pkgconfig_url="https://github.com/google/zopfli"

. xbuilder.sh

start

# Filelist
# --------

# include/zopflipng_lib.h
# include/zopfli.h
# lib/cmake/Zopfli/ZopfliConfigVersion.cmake
# lib/cmake/Zopfli/ZopfliConfig.cmake
# lib/cmake/Zopfli/ZopfliConfig-release.cmake
# lib/libzopflipng.so
# lib/libzopfli.so
# bin/zopflipng
# bin/zopfli
