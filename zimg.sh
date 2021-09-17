#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='zimg'
dsc='Scaling, colorspace conversion, and dithering library'
lic='WTFPL'
src='https://github.com/sekrit-twc/zimg.git'
sty='git'
cfg='ag'
eta='120'
cbk='example'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start

# Filelist
# --------
# include/zimg.h
# include/zimg++.hpp
# lib/pkgconfig/zimg.pc
# lib/libzimg.so
# lib/libzimg.a
# lib/libzimg.la
# share/doc/zimg/example/api_example.cpp
# share/doc/zimg/example/interlace_example.cpp
# share/doc/zimg/example/hdr_example.cpp
# share/doc/zimg/example/tile_example.cpp
# share/doc/zimg/example/Makefile
# share/doc/zimg/example/api_example_c.c
# share/doc/zimg/example/misc/mmap.cpp
# share/doc/zimg/example/misc/mmap.h
# share/doc/zimg/example/misc/win32_bitmap.h
# share/doc/zimg/example/misc/argparse.h
# share/doc/zimg/example/misc/win32_bitmap.cpp
# share/doc/zimg/example/misc/argparse.cpp
# share/doc/zimg/example/misc/aligned_malloc.h
# share/doc/zimg/README.md
# share/doc/zimg/ChangeLog
# share/doc/zimg/COPYING
