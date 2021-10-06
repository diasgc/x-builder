#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   F.. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='mega'
apt="${lib}-dev"
dsc='MEGA cloud storage C++ SDK'
lic='BSD-2c'
src='https://github.com/meganz/sdk.git' #src_opt='--recurse-submodules'
cfg='ar'
dep='openssl libcares curl libraw libuv libmediainfo cryptopp sqlite3 readline libsodium' #freeimage
eta='10'
mki='install-strip'
mkc='distclean'
CFG="--disable-tests --disable-examples --without-pdfium"
lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} -with-pic=1 $CFG"
CPPFLAGS+=" -Wno-deprecated-declarations -Wno-inconsistent-missing-override"
start