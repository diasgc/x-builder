#!/bin/bash

lib='zimg'
dsc='Scaling, colorspace conversion, and dithering library'
lic='WTFPL'
src='https://github.com/sekrit-twc/zimg.git'
cfg='ag'
eta='120'

lst_inc='zimg.h zimg++.hpp'
lst_lib='libzimg'
lst_bin=''
lst_lic='COPYING'
lst_pc='zimg.pc'

dev_bra='main'
dev_vrs=''
stb_bra=''
stb_vrs=''

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

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
