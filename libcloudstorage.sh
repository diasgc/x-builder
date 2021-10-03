#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ... ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libcloudstorage'
apt="${libcloudstorage}-dev"
dsc='A C++  library providing access to files located in various cloud services licensed under GNU LGPLv2.1'
lic='LGPL-2.1'
src='https://code.videolan.org/videolan/libcloudstorage.git'
cfg='ac'
eta='60'
dep='jsoncpp'
mki='install-strip'
mkc='distclean'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

source_config(){
    cd $SRCDIR
    ./bootstrap
}

start