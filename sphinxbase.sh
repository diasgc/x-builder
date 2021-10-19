#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='sphinxbase'
dsc='CMU Sphinx common libraries'
lic='BSD-2c'
src='https://github.com/cmusphinx/sphinxbase.git'
cfg='ag'
eta='0'

lst_inc=''
lst_lib=''
lst_bin=''
CFG='--without-python'

. xbuilder.sh

start