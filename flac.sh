#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++ +++ +++ +++ clang
# GNU +++ +++  .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='flac'
dsc='Free Lossless Audio Codec'
lic='BSD'
src='https://github.com/xiph/flac.git'
cfg='ag'
dep='ogg libiconv'
eta='60'

lst_inc='FLAC++/decoder.h FLAC++/metadata.h
	FLAC++/export.h FLAC++/encoder.h
	FLAC++/all.h
  FLAC/metadata.h FLAC/format.h
	FLAC/stream_decoder.h FLAC/stream_encoder.h
	FLAC/export.h FLAC/callback.h
	FLAC/ordinals.h FLAC/all.h
	FLAC/assert.h'
lst_lib='libFLAC libFLAC++'
lst_bin='flac metaflac'

. xbuilder.sh

case $build_tool in
  cmake)
    CFG="-DBUILD_CXXLIBS=ON -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF -DINSTALL_MANPAGES=OFF -DWITH_ASM=ON -DWITH_OGG=ON"
    [ "$PLATFORM" == "Windows" ] && LD=$CC; AS=nasm
    $build_bin && CBH="-DBUILD_PROGRAMS=ON" || CBH="-DBUILD_PROGRAMS=OFF"
    ;;
  automake)
    CFG="--with-sysroot=${SYSROOT} --with-pic"
    $host_arm && CFG+=" --disable-asm-optimizations --disable-vsx --disable-avx --disable-sse --disable-altivec"
    ;;
esac

build_patch_config(){
  # Patch to remove docs (automake)
  [ "$build_tool" == "automake" ] && sed -i "s|SUBDIRS = doc include|SUBDIRS = include|g" $SRCDIR/Makefile
}
start

# Filelist
# --------
# include/FLAC++/decoder.h
# include/FLAC++/metadata.h
# include/FLAC++/export.h
# include/FLAC++/encoder.h
# include/FLAC++/all.h
# include/FLAC/metadata.h
# include/FLAC/format.h
# include/FLAC/stream_decoder.h
# include/FLAC/stream_encoder.h
# include/FLAC/export.h
# include/FLAC/callback.h
# include/FLAC/ordinals.h
# include/FLAC/all.h
# include/FLAC/assert.h
# lib/pkgconfig/flac.pc
# lib/pkgconfig/flac++.pc
# lib/libFLAC.so
# lib/libFLAC.a
# lib/libFLAC++.so
# lib/libFLAC.la
# lib/libFLAC++.a
# lib/libFLAC++.la
# share/man/man1/flac.1
# share/man/man1/metaflac.1
# share/aclocal/libFLAC++.m4
# share/aclocal/libFLAC.m4
# bin/flac
# bin/metaflac
