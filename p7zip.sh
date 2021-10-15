#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='p7zip'
dsc='p7zip is a port of the Windows programs 7z.exe and 7za.exe provided by 7-zip'
lic='MLP-2.0'
src='https://github.com/jinfeihan57/p7zip.git'
cfg='cmake'
API=28
dir_config='CPP/7zip/CMAKE'
eta='60'

. xbuilder.sh

start