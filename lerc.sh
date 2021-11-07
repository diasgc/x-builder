#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++. ++. ++. ++.
# linux-gnu   ... ... ... ...
# mingw-llvm  ++. ++. ... ...

lib='lerc'
pkg='Lerc'
dsc='Limited Error Raster Compression'
lic='BSD/GPL-2.0'
src='https://github.com/Esri/lerc.git'
sty='git'
cfg='cm'
eta='134'

. xbuilder.sh

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-09-19 17:54:30.960105600 +0100
+++ CMakeLists.txt	2021-09-19 18:01:45.760105600 +0100
@@ -27,10 +27,15 @@
 
 if(BUILD_SHARED_LIBS)
     set_target_properties(Lerc PROPERTIES DEFINE_SYMBOL LERC_EXPORTS)
+    add_library(Lerc_static STATIC ${SOURCES})
+    set_target_properties(Lerc Lerc_static PROPERTIES OUTPUT_NAME Lerc)
+    set(LERC_TARGETS Lerc Lerc_static)
+else()
+    set(LERC_TARGETS Lerc)
 endif()
 
 install(
-    TARGETS Lerc
+    TARGETS ${LERC_TARGETS}
     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
     ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
XB_APPLY_PATCH

# Filelist
# --------
# include/Lerc_c_api.h
# include/Lerc_types.h
# lib/pkgconfig/Lerc.pc
# lib/libLerc.so
# lib/libLerc.a