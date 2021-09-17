#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='openh264'
dsc='Open Source H.264 Codec'
lic='BSD-2c'
src='https://github.com/cisco/openh264.git'
sty='git'
cfg='meson'
eta='160'

. xbuilder.sh
MAKE_EXECUTABLE=ninja
CFG="-Db_pie=true -Db_lto=true"

build_make_package(){
    DESTDIR=${1} ninja -C ${BUILD_DIR} install
}

start

# Filelist
# --------

# include/wels/codec_api.h
# include/wels/codec_ver.h
# include/wels/codec_def.h
# include/wels/codec_app_def.h
# lib/pkgconfig/openh264.pc
# lib/libopenh264.a
# lib/libopenh264.so
