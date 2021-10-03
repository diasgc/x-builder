#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ... ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='pscs'
apt='libpscs-dev'
dsc='Middleware to access a smart card using SCard API (PC/SC)'
lic='BSD-3c'
src='https://github.com/LudovicRousseau/PCSC.git'
cfg='ac'
eta='10'
dep='libusb'
mki='install-strip'
mkc='distclean'

lst_inc=''
lst_lib=''

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-libsystemd --disable-libudev"

source_config(){
    pushdir $SRCDIR
    ./bootstrap
    autoreconf -i
    popdir
}

start