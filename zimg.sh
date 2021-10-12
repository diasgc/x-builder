#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='zimg'
dsc='Scaling, colorspace conversion, and dithering library'
lic='WTFPL'
src='https://github.com/sekrit-twc/zimg.git'
sty='git'
cfg='ag'
eta='120'
cbk='example'

lst_lic='share/doc/zimg/COPYING'
lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

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
