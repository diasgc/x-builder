#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='libmysofa'
apt="${lib}-dev"
dsc='Reader for AES SOFA files to get better HRTFs'
lic='BSD'
src='https://github.com/hoene/libmysofa.git'
cfg='cmake'
dep='libcunit'
pkg='libmysofa'
eta='60'

. xbuilder.sh

# CMAKE OPTIONS (default): -DADDRESS_SANITIZE=OFF -DCODE_COVERAGE=OFF 

CFG="-DBUILD_TESTS=OFF"
[[ $arch = *mingw32 ]] && dep="$dep zlib"

start

# Filelist
# --------
# include/mysofa.h
# lib/pkgconfig/libmysofa.pc
# lib/libmysofa.so
# lib/libmysofa.a
# share/libmysofa/MIT_KEMAR_normal_pinna.sofa
