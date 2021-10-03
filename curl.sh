#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ... ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='curl'
apt="${lib}-dev"
dsc='A command line tool and library for transferring data with URL syntax'
lic='Other'
src='https://github.com/curl/curl.git'
cfg='ar'
eta='60'
dep='openssl'
mki='install-strip'
mkc='distclean'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --with-openssl"

start