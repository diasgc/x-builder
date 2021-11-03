#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU +++  .   .   .  gcc
# WIN +++  .   .   .  clang/gcc

lib='pcre2'
apt='libpcre2-dev'
pkg='libpcre2-8'
dsc='New Perl Compatible Regular Expression Library'
lic='BSD-3c'
src='https://github.com/PhilipHazel/pcre2.git'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
#cbk=''
CFG='-DPCRE2_BUILD_PCRE2_32=ON -DPCRE2_BUILD_PCRE2_16=ON -DPCRE2_BUILD_TESTS=OFF'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

$host_mingw || CFG+=' -DPCRE2_STATIC_PIC=ON'

start

<<'XB_APPLY_PATCH'
--- CMakeLists.old	2021-11-02 10:11:28.156000000 +0000
+++ CMakeLists.txt	2021-11-02 10:12:41.268513000 +0000
@@ -180,7 +180,7 @@
 SET(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared libraries.")
 
 OPTION(BUILD_STATIC_LIBS "Build static libraries." ON)
-
+OPTION(INSTALL_DOCS "Install documents and man pages" OFF)
 OPTION(PCRE2_BUILD_PCRE2_8 "Build 8 bit PCRE2 library" ON)
 
 OPTION(PCRE2_BUILD_PCRE2_16 "Build 16 bit PCRE2 library" OFF)
@@ -1027,10 +1027,11 @@
         SET(man3_new ${man3} ${man})
 ENDFOREACH(man ${man3})
 SET(man3 ${man3_new})
-
+IF(INSTALL_DOCS)
 INSTALL(FILES ${man1} DESTINATION man/man1)
 INSTALL(FILES ${man3} DESTINATION man/man3)
 INSTALL(FILES ${html} DESTINATION share/doc/pcre2/html)
+ENDIF(INSTALL_DOCS)
 
 IF(MSVC AND INSTALL_MSVC_PDB)
     INSTALL(FILES ${PROJECT_BINARY_DIR}/pcre2.pdb

XB_APPLY_PATCH


# Filelist
# --------
# include/pcre2posix.h
# include/pcre2.h
# cmake/pcre2-config-version.cmake
# cmake/pcre2-config.cmake
# lib/pkgconfig/libpcre2-32.pc
# lib/pkgconfig/libpcre2-posix.pc
# lib/pkgconfig/libpcre2-16.pc
# lib/pkgconfig/libpcre2-8.pc
# lib/libpcre2-32.a
# lib/libpcre2-16.a
# lib/libpcre2-8.so
# lib/libpcre2-16.so
# lib/libpcre2-posix.so
# lib/libpcre2-posix.a
# lib/libpcre2-8.a
# lib/libpcre2-32.so
# bin/pcre2-config
# bin/pcre2grep
