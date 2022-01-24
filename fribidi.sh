#!/bin/bash

lib='fribidi'
apt='libfribidi0'
dsc='Unicode Bidirectional Algorithm Library'
lic='LGPL-2.1'
src='https://github.com/fribidi/fribidi.git'
cfg='meson'
eta='60'
CFG="-Db_lto=true -Ddocs=false"

lst_inc='fribidi/*.h'
lst_lib='libfribidi.*'
lst_bin='fribidi'
lst_lic='COPYING AUTHORS'
lst_pc='fribidi.pc'

. xbuilder.sh

$host_mingw || CFG+=' -Db_pie=true'

start

# cpu av8 av7 x86 x64
# NDK +++ +++  .   .  clang
# GNU +++  .   .   .  gcc
# WIN +++  .   .  +++ clang/gcc
