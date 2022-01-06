#!/bin/bash


lib='dav1d'
apt='libdav1d-dev'
dsc='AV1 cross-platform decoder, open-source, and focused on speed and correctness.'
lic='GPL-2.0'
src='https://code.videolan.org/videolan/dav1d.git'
cfg='meson'
tls='meson ninja'
eta='40'
cb0='-Denable_tools=false'
cb1='-Denable_tools=true'

. xbuilder.sh

CFG="-Db_pie=true -Db_lto=true"

build_make_package(){
    DESTDIR=${1} ninja -C ${BUILD_DIR} install
}

start

#             a8  a7  x86 x64
# ndk-clang   PP+ ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

# Filelist
# --------
# include/dav1d/common.h
# include/dav1d/data.h
# include/dav1d/dav1d.h
# include/dav1d/picture.h
# include/dav1d/headers.h
# include/dav1d/version.h
# lib/pkgconfig/dav1d.pc
# lib/libdav1d.so
# bin/dav1d
