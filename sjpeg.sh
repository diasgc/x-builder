#!/bin/bash

lib='sjpeg'
dsc='SimpleJPEG: simple jpeg encoder'
lic='Apache2.0'
src='https://github.com/webmproject/sjpeg.git'
src_opt="--recursive"
cfg='cm'
eta='10'

. xbuilder.sh
CFG="-DSJPEG_ANDROID_NDK_PATH=${ANDROID_NDK_HOME}"

start

#     Aa8 Aa7 A86 A64
# NDK ... ... ... ... CLANG
# GNU ... ... ... ... GCC
# WIN ... ... ... ... CLANG/GCC