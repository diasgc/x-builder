#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ clang
# GNU ...  .   .   .  gcc
# WIN +++  .   .  +++ clang/gcc

lib='brunsli'
pkg='brunslienc-c'
dsc='Practical JPEG Repacker'
lic='MIT'
src='https://github.com/google/brunsli.git'
cfg='cmake'
eta='30'

lst_inc='brunsli/jpeg_data_writer.h
	brunsli/status.h
	brunsli/brunsli_encode.h
	brunsli/types.h
	brunsli/decode.h
	brunsli/brunsli_decode.h
	brunsli/jpeg_data.h
	brunsli/jpeg_data_reader.h
	brunsli/encode.h'
lst_lib='libbrunslidec-c libbrunslienc-c'
lst_bin='dbrunsli cbrunsli'

req_pcforlibs=$lst_lib

CFG="-DBUILD_TESTING=OFF -DINSTALL_GTEST=OFF"

. xbuilder.sh

source_patch(){
    pushdir $SRCDIR
    git submodule update --init
    popdir
}

start

<<'XB_APPLY_PATCH'
--- brunsli.cmake	2021-10-06 22:13:05.628152000 +0100
+++ brunsli.cmake	2021-10-06 22:13:09.258152000 +0100
@@ -74,7 +74,8 @@
 )
 
 set(BRUNSLI_LIBRARIES brunslicommon-static brunslidec-static brunslienc-static)
-
+set_target_properties(brunslienc-static PROPERTIES OUTPUT_NAME brunslienc-c)
+set_target_properties(brunslidec-static PROPERTIES OUTPUT_NAME brunslidec-c)
 if(NOT BRUNSLI_EMSCRIPTEN)
 add_library(brunslidec-c SHARED
   c/dec/decode.cc
@@ -153,7 +154,7 @@
 # Installation
 if(NOT BRUNSLI_EMSCRIPTEN)
   install(
-    TARGETS brunslidec-c brunslienc-c
+    TARGETS brunslidec-c brunslienc-c brunslidec-static brunslienc-static
     ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
     LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
   )
@@ -171,6 +172,8 @@
   RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/artifacts"
 )
 
+install(TARGETS cbrunsli dbrunsli RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
+
 if (${BUILD_TESTING})
 
 include(GoogleTest)

XB_APPLY_PATCH

# Filelist
# --------
# include/brunsli/jpeg_data_writer.h
# include/brunsli/status.h
# include/brunsli/brunsli_encode.h
# include/brunsli/types.h
# include/brunsli/decode.h
# include/brunsli/brunsli_decode.h
# include/brunsli/jpeg_data.h
# include/brunsli/jpeg_data_reader.h
# include/brunsli/encode.h
# lib/libbrunslidec-c.so
# lib/pkgconfig/brunslienc-c.pc
# lib/pkgconfig/brunslidec-c.pc
# lib/libbrunslienc-c.so
# lib/libbrunslidec-c.a
# lib/libbrunslienc-c.a
# bin/dbrunsli
# bin/cbrunsli
