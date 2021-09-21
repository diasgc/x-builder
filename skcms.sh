#!/bin/bash

lib='skcms'
dsc='PNG encoder and decoder in C and C++'
lic='BSD-3c'
src='(https://skia.googlesource.com/skcms'
cfg='bazel'
eta='10'

. xbuilder.sh

build_all(){

}

start

#     Aa8 Aa7 A86 A64
# NDK ... ... ... ... CLANG
# GNU ... ... ... ... GCC
# WIN ... ... ... ... CLANG/GCC