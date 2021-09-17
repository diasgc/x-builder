#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+ -/+  .   .   .   .   .   .   .   .   .  static
# +/- +/-  .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

lib='vvdec'
pkg='libvvdec'
dsc='Fraunhofer Versatile Video Decoder (VVdeC)'
lic='LGPL-2.1'
src='https://github.com/fraunhoferhhi/vvdec.git'
sty='git'
cfg='cm'
eta='480'
cbk="BUILD_TOOLS"

mkinstall='all'

. xbuilder.sh

case $arch in
  aarch64*|arm*) CFG="-DVVDEC_ENABLE_X86_SIMD=FALSE -DVVDEC_ENABLE_ARM_SIMD=TRUE";;
esac

source_patch(){
  sed -i 's/^set( VVDEC_ENABLE_X86_SIMD/option( VVDEC_ENABLE_X86_SIMD/' $SRCDIR/CMakeLists.txt
  sed -i 's/^set( VVDEC_ENABLE_ARM_SIMD/option( VVDEC_ENABLE_ARM_SIMD/' $SRCDIR/CMakeLists.txt
  sed -i '$!N;s/^.*\n.*malloc_trim/#if defined( __linux__ ) \&\& \!defined(__ANDROID__)\n  malloc_trim/;P;D' $SRCDIR/source/Lib/vvdec/vvdecimpl.cpp
}

start

# Filelist
# --------
# include/vvdec/sei.h
# include/vvdec/vvdec.h
# include/vvdec/version.h
# include/vvdec/vvdecDecl.h
# lib/pkgconfig/libvvdec.pc
# lib/cmake/vvdec/vvdecConfigVersion.cmake
# lib/cmake/vvdec/vvdecTargets-shared.cmake
# lib/cmake/vvdec/vvdecTargets-shared-release.cmake
# lib/cmake/vvdec/vvdecConfig.cmake
# lib/libvvdec.so
# bin/vvdecapp
