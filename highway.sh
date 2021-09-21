#!/bin/bash

lib='highway'
dsc='Performance-portable, length-agnostic SIMD with runtime dispatch'
lic='Apache2.0'
src='https://github.com/google/highway.git'
cfg='cm'
eta='10'

. xbuilder.sh
CFG="-DBUILD_GMOCK=OFF -DBUILD_TESTING=OFF -DHWY_EXAMPLES_TESTS_INSTALL=OFF"
case $arch in arm*) CFG+="-DHWY_CMAKE_ARM7=ON";; esac

start

#     Aa8 Aa7 A86 A64
# NDK ... ... ... ... CLANG
# GNU ... ... ... ... GCC
# WIN ... ... ... ... CLANG/GCC