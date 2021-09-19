#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   . static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='pzip'
dsc='c++ library wrapper of 7zip'
lic='MLP-2.0'
src='https://github.com/jinfeihan57/p7zip.git'
sty='git'
cfg='mk'

eta='1095'

. xbuilder.sh

start