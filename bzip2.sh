#!/bin/bash

lib='bzip2'
dsc='Lossless, block-sorting data compression'
lic='Other'
src='https://gitlab.com/bzip2/bzip2.git'
cfg='cmake'
eta='20'
cstk="ENABLE_STATIC_LIB"
cshk="ENABLE_SHARED_LIB"
cbk="ENABLE_APP"
CFG="-DENABLE_EXAMPLES=OFF -DENABLE_DOCS=OFF"

. xbuilder.sh

start

#             a8  a7  x86 x64
# ndk-clang   +++ +++ ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

# Filelist
# --------
# include/bzlib.h
# man/man1/bzmore.1
# man/man1/bzip2.1
# man/man1/bzgrep.1
# man/man1/bzdiff.1
# lib/pkgconfig/bzip2.pc
# lib/libbz2.so
# lib/libbz2_static.a
# bin/bzgrep
# bin/bzdiff
# bin/bzip2recover
# bin/bzmore
# bin/bzip2
