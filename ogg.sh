#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++o ++o ++o ++o
# linux-gnu   ++o +++ ... ...
# mingw-llvm  ++o ++o ... ...

lib='ogg'
apt='libogg0'
dsc='Ogg media container'
lic='BSD'
src='https://github.com/xiph/ogg.git'
cfg='ag'
eta='45'
cbk="able-extra-programs"

lst_pc='ogg.pc'
lst_inc='ogg/config_types.h ogg/ogg.h ogg/os_types.h'
lst_lib='libogg'

. xbuilder.sh

case $cfg in
  cm|ccm|cmake|ccmake)
    CFG="-DBUILD_TESTING=OFF -DINSTALL_DOCS=OFF"
    ;;
  ac|ag|ar|autotools)
    #[ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
    #CFG="--with-sysroot=${SYSROOT} --with-pic=1"
    ;;
esac

build_patch_config(){
  # Patch to remove docs (automake)
  [ "$cfg" == "ag" ] && sed -i "s|SUBDIRS = src include doc|SUBDIRS = src include|g" Makefile || echo
}

start

# Filelist
# --------
# include/ogg/config_types.h
# include/ogg/ogg.h
# include/ogg/os_types.h
# lib/pkgconfig/ogg.pc
# lib/libogg.so.0.8.5
# lib/libogg.la
# lib/libogg.a
# share/aclocal/ogg.m4
