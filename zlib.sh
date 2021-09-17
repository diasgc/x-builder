#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   +   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='zlib'
apt='zlib1g'
dsc='zlib compression library'
lic='Free'
src='https://github.com/madler/zlib.git'
sty='git'
cfg='cm'
eta='22'
cb0="-DBUILD_TOOLS=OFF"
cb1="-DBUILD_TOOLS=ON"

. xbuilder.sh

#CFG="-DINSTALL_PKGCONFIG_DIR=${INSTALL_DIR}/lib/pkgconfig"

build_pkgconfig_file(){
    [ ! -f "$INSTALL_DIR/lib/libz.a" ] && [ -f "$INSTALL_DIR/lib/libzlib.dll.a" ] && ln -s $INSTALL_DIR/lib/libzlib.dll.a $INSTALL_DIR/lib/libz.a
    [ ! -f "$INSTALL_DIR/lib/libzstatic.a" ] && [ -f "$INSTALL_DIR/lib/libzlibstatic.a" ] && ln -s $INSTALL_DIR/lib/libzlibstatic.a $INSTALL_DIR/lib/libzstatic.a
    echo -ne " "
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
