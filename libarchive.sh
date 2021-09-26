#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   F.. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libarchive'
apt='libarchive-dev'
dsc='Multi-format archive and compression library'
lic='Other'
src='https://github.com/libarchive/libarchive.git'
cfg='cmake'
dep='pcre expat libxml2 pcreposix libgcc openssl bzip2 liblzma libb2 lz4 zstd zlib'
#cstk='BUILD_STATIC'
#cshk='BUILD_SHARED'
#cbk='BUILD_BENCHMARKS'
eta='100'

#CFG="-DBUILD_TESTS=OFF -DBUILD_FUZZERS=OFF"

lst_inc=''
lst_lib=$lib
lst_bin=''
lst_oth=''

. xbuilder.sh

start
