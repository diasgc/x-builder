#!/bin/bash

lib='ogg'
apt='libogg0'
dsc='Ogg media container'
lic='BSD'
src='https://github.com/xiph/ogg.git'
cfg='cm'
eta='45'
mki='install'
#cbk="able-extra-programs"

lst_inc='ogg/*.h'
lst_lib='libogg'
lst_bin=''
lst_lic='COPYING AUTHORS'
lst_pc='ogg.pc'

. xbuilder.sh

cfg_cmake='-DBUILD_TESTING=OFF -DINSTALL_DOCS=OFF'

build_patch_config(){
  # Patch to remove docs (automake)
  [ "$build_tool" == "automake" ] && sed -i "s|SUBDIRS = src include doc|SUBDIRS = src include|g" Makefile
  return 0
}

start

# cpu av8 av7 x86 x64
# NDK ++  ++  ++  ++  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc



# Filelist
# --------
# include/ogg/config_types.h
# include/ogg/ogg.h
# include/ogg/os_types.h
# lib/pkgconfig/ogg.pc
# lib/libogg.la
# lib/libogg.a
# lib/libogg.so
# share/doc/ogg/AUTHORS
# share/doc/ogg/COPYING
# share/aclocal/ogg.m4
