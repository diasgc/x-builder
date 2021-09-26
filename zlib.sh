#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   +   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='zlib'
apt='zlib1g'
dsc='zlib compression library'
lic='zlib'
src='https://github.com/madler/zlib.git'
cfg='cm'
eta='22'
cbk="BUILD_TOOLS"
mkc='distclean'

lst_inc='zlib.h'
lst_lib='libz'
lst_pc='zlib.pc'

. xbuilder.sh

source_patch(){
    # Is it a bug?
    sed -i '/^set(INSTALL_PKGCONFIG_DIR.*/s/share/lib/'  CMakeLists.txt
}
str_contains arch "mingw32" && {
    [ ! -f "$INSTALL_DIR/lib/libz.a" ] && [ -f "$INSTALL_DIR/lib/libzlib.dll.a" ] && ln -s $INSTALL_DIR/lib/libzlib.dll.a $INSTALL_DIR/lib/libz.a
    [ ! -f "$INSTALL_DIR/lib/libzstatic.a" ] && [ -f "$INSTALL_DIR/lib/libzlibstatic.a" ] && ln -s $INSTALL_DIR/lib/libzlibstatic.a $INSTALL_DIR/lib/libzstatic.a
}
start



# Filelist
# --------
# include/zlib.h
# include/zconf.h
# lib/pkgconfig/zlib.pc
# lib/libz.a
# lib/libz.so.1.2.11
# share/man/man3/zlib.3
