#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP+  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libssh2'
dsc='the SSH library'
lic='GLP-2.0'
src='https://github.com/libssh2/libssh2.git'
dep='openssl' # or Libgcrypt or mbedTLS
cfg='cmake' # or ar
eta='0'
CFG='-DBUILD_TESTING=OFF -DINSTALL_DOCS=OFF'
#cshk=''
#cstk=''
cbk='BUILD_EXAMPLES'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-10-18 21:46:27.045000000 +0100
+++ CMakeLists.txt	2021-10-18 21:47:11.454859100 +0100
@@ -50,6 +50,7 @@
 endif()
 
 option(BUILD_SHARED_LIBS "Build Shared Libraries" OFF)
+option(INSTALL_DOCS "Install Docs" OFF)
 
 # Parse version
 
@@ -106,7 +107,9 @@
   add_dependencies(libssh2 lint)
 endif()
 
+if(INSTALL_DOCS)
 add_subdirectory(docs)
+endif()
 
 feature_summary(WHAT ALL)

XB_APPLY_PATCH

# Filelist
# --------
# include/libssh2_sftp.h
# include/libssh2.h
# include/libssh2_publickey.h
# lib/pkgconfig/libssh2.pc
# lib/cmake/libssh2/Libssh2ConfigVersion.cmake
# lib/cmake/libssh2/Libssh2Config-release.cmake
# lib/cmake/libssh2/Libssh2Config.cmake
# lib/libssh2.so
# share/doc/libssh2/NEWS
# share/doc/libssh2/AUTHORS
# share/doc/libssh2/RELEASE-NOTES
# share/doc/libssh2/HACKING
# share/doc/libssh2/COPYING
# share/doc/libssh2/README
