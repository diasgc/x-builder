#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   F.. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='freeimagelite'
apt="${lib}-dev"
dsc='FreeImage is an Open Source library'
lic='Other'
src='https://github.com/WohlSoft/libFreeImage.git'
cfg='cmake'
dep='libpng libjpeg libtiff'
eta='100'

lst_inc='FreeImageLite.h'
lst_lib='libFreeImageLite'
lst_bin=''

. xbuilder.sh

start

# Filelist
# --------
# include/FreeImageLite.h
# lib/libFreeImageLite.a
# lib/libFreeImageLite.so
