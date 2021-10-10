#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK SYS------------ clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='zlib'
apt='zlib1g'
dsc='zlib compression library'
lic='Zlib'
src='https://github.com/madler/zlib.git'
cfg='cmake'
eta='22'
cbk="BUILD_TOOLS"
mkc='distclean'

lst_inc='zlib.h zconf.h'
lst_lib='libz'
lst_pc='zlib.pc'

. xbuilder.sh

on_end(){
    [ "$host_os" == "mingw32" ] && {
        ln -s $INSTALL_DIR/lib/libzlib.dll.a $INSTALL_DIR/lib/libz.a 2>/dev/null
        ln -s $INSTALL_DIR/lib/libzlibstatic.a $INSTALL_DIR/lib/libzstatic.a 2>/dev/null
    }
}

if [ "$host_os" == "android" ];then
    pc_libdir="/lib/${arch}"
    create_pkgconfig_file zlib '-lz' "${SYSROOT}/usr"
else
    start
fi

<<'XB_PATCH_CMAKELISTS'
--- CMakeLists.old	2021-10-10 20:18:11.063314400 +0100
+++ CMakeLists.txt	2021-10-09 20:20:36.918086800 +0100
@@ -12,7 +12,7 @@
 set(INSTALL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib" CACHE PATH "Installation directory for libraries")
 set(INSTALL_INC_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "Installation directory for headers")
 set(INSTALL_MAN_DIR "${CMAKE_INSTALL_PREFIX}/share/man" CACHE PATH "Installation directory for manual pages")
-set(INSTALL_PKGCONFIG_DIR "${CMAKE_INSTALL_PREFIX}/share/pkgconfig" CACHE PATH "Installation directory for pkgconfig (.pc) files")
+set(INSTALL_PKGCONFIG_DIR "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" CACHE PATH "Installation directory for pkgconfig (.pc) files")
 
 include(CheckTypeSize)
 include(CheckFunctionExists)

XB_PATCH_CMAKELISTS

# Filelist
# --------
# include/zlib.h
# include/zconf.h
# lib/pkgconfig/zlib.pc
# lib/libz.a
# lib/libz.so.1.2.11
# share/man/man3/zlib.3
