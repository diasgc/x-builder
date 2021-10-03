#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   F.. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='mega'
apt="${lib}-dev"
dsc='MEGA cloud storage C++ SDK'
lic='BSD-2c'
src='https://github.com/meganz/sdk.git' src_opt='--recurse-submodules'
cfg='ar'
dep='openssl libcares libcurl libasio freeimage libraw libuv mediainfo pcre pdfium qt sqlite webrct'
eta='10'
mki='install-strip'
mkc='distclean'

#cfg='cmake'
#CFG="-DMega3rdPartyDir=$SRCDIR/third_party -"
lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

#CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start