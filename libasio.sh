#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ... ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libasio'
apt="${lib}-dev"
dsc='Asio C++ Library'
lic='Boost'
src='https://github.com/chriskohlhoff/asio.git'
cfg='ag'
eta='10'
lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

SRCDIR="$SRCDIR/asio"

start