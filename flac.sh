#!/bin/bash

lib='flac'
dsc='Free Lossless Audio Codec'
lic='BSD'
src='https://github.com/xiph/flac.git'
cfg='ag'
dep='ogg libiconv'
eta='60'

lst_inc='FLAC++/*.h FLAC/*.h'
lst_lib='libFLAC.* libFLAC++.*'
lst_bin='flac metaflac'
lst_lic='COPYING.FDL COPYING.GPL COPYING.LGPL COPYING.Xiph AUTHORS'
lst_pc='flac.pc flac++.pc'

. xbuilder.sh

case $build_tool in
  cmake)
    CFG="-DBUILD_CXXLIBS=ON -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DINSTALL_MANPAGES=OFF -DWITH_ASM=ON -DWITH_OGG=ON"
    $host_mingw && {
      LD=$CC; AS=nasm
    }
    $build_bin && CBH="-DBUILD_PROGRAMS=ON" || CBH="-DBUILD_PROGRAMS=OFF"
    ;;
  automake)
    $host_arm && CFG+=" --disable-asm-optimizations --disable-vsx --disable-avx --disable-sse --disable-altivec"
    ;;
esac

build_patch_config(){
  # Patch to remove docs (automake)
  [ "$build_tool" == "automake" ] && sed -i "s|SUBDIRS = doc include|SUBDIRS = include|g" $SRCDIR/Makefile
}

start

# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ clang
# GNU +++ +++  .   .  gcc
# WIN  .   .   .   .  clang/gcc