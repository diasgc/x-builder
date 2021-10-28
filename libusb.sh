#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ... ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libusb'
apt='libpscs-dev'
dsc='A cross-platform library to access USB devices'
lic='LGPL-2.1'
src='https://github.com/libusb/libusb.git'
cfg='ac'
eta='10'
dep='systemd'
automake_cmd='./bootstrap.sh'

lst_inc=''
lst_lib=''

. xbuilder.sh

_source_config(){
    pushdir $SRCDIR
    ./bootstrap.sh
    popdir
}

start