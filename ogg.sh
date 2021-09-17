#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='ogg'
apt='libogg0'
dsc='Ogg media container'
lic='BSD'
src='https://github.com/xiph/ogg.git'
sty='git'
cfg='ag'
tls=''
dep=''
eta='187'
cb0="--disable-extra-programs"
cb1="--enable-extra-programs"

. xbuilder.sh

case $cfg in
  cm|ccm|cmake|ccmake)
    CFG="-DBUILD_TESTING=OFF -DINSTALL_DOCS=OFF"
    ;;
  ac|ag|ar|autotools)
    [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
    CFG="--with-sysroot=${SYSROOT} --with-pic=1"
    ;;
esac

build_patch_config(){
  # Patch to remove docs (automake)
  [ "$cfg" == "ag" ] && sed -i "s|SUBDIRS = src include doc|SUBDIRS = src include|g" Makefile
}

start

# CMake-Filelist
# --------

# include/ogg/config_types.h
# include/ogg/ogg.h
# include/ogg/os_types.h
# lib/pkgconfig/ogg.pc
# lib/cmake/Ogg/OggTargets.cmake
# lib/cmake/Ogg/OggTargets-release.cmake
# lib/cmake/Ogg/OggConfigVersion.cmake
# lib/cmake/Ogg/OggConfig.cmake
# lib/libogg.so

# Filelist (patched no-docs)
# --------
# include/ogg/config_types.h
# include/ogg/ogg.h
# include/ogg/os_types.h
# lib/pkgconfig/ogg.pc
# lib/libogg.la
# lib/libogg.a
# lib/libogg.so
# share/aclocal/ogg.m4