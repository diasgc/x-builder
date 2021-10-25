#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++  ++  ++  ++  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='soxr'
apt='libsoxr-dev'
dsc='The SoX resampler library'
lic='LGPL-2.1'
src='https://git.code.sf.net/p/soxr/code' sty='git'
cfg='cmake'
eta='45'
cbk='DBUILD_EXAMPLES'
CFG='-DBUILD_TESTS=OFF'
lst_inc='soxr.h soxr-lsr.h'
lst_lib='libsoxr.a libsoxr-lsr.a'
lst_bin=''
lst_lic='share/doc/libsoxr/LICENCE'

. xbuilder.sh

start

<<'XB_APPLY_PATCH'
--- src/CMakeLists.old	2021-10-12 17:52:50.319000000 +0100
+++ src/CMakeLists.txt	2021-10-12 18:07:42.453128100 +0100
@@ -84,6 +84,12 @@
   INSTALL_NAME_DIR ${LIB_INSTALL_DIR}
   LINK_INTERFACE_LIBRARIES ""
   PUBLIC_HEADER "${PROJECT_NAME}.h")
+if(BUILD_SHARED_LIBS AND BUILD_STATIC_LIBS)
+  set(PROJECT_NAME_STATIC ${PROJECT_NAME}-static)
+  add_library (${PROJECT_NAME_STATIC} STATIC ${SOURCES})
+  target_link_libraries (${PROJECT_NAME_STATIC} PRIVATE ${LIBS} ${LIBM_LIBRARIES})
+  set_target_properties (${PROJECT_NAME_STATIC} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
+endif()
 if (BUILD_FRAMEWORK)
   set_target_properties (${PROJECT_NAME} PROPERTIES FRAMEWORK TRUE)
 elseif (NOT WIN32)
@@ -115,13 +121,19 @@
     configure_file (${CMAKE_CURRENT_SOURCE_DIR}/${LSR}.pc.in ${CMAKE_CURRENT_BINARY_DIR}/${LSR}.pc)
     install (FILES ${CMAKE_CURRENT_BINARY_DIR}/${LSR}.pc DESTINATION ${LIB_INSTALL_DIR}/pkgconfig)
   endif ()
+  if(BUILD_SHARED_LIBS AND BUILD_STATIC_LIBS)
+    set(LSR_STATIC ${LSR}_static)
+    add_library (${LSR_STATIC} STATIC ${LSR})
+    target_link_libraries (${LSR_STATIC} ${PROJECT_NAME_STATIC})
+    set_target_properties (${LSR_STATIC} PROPERTIES OUTPUT_NAME ${LSR})
+  endif()
 endif ()
 
 
 
 # Installation (from build from source):
 
-install (TARGETS ${PROJECT_NAME} ${LSR}
+install (TARGETS ${PROJECT_NAME} ${PROJECT_NAME_STATIC} ${LSR} ${LSR_STATIC}
   FRAMEWORK DESTINATION ${FRAMEWORK_INSTALL_DIR}
   LIBRARY DESTINATION ${LIB_INSTALL_DIR}
   RUNTIME DESTINATION ${BIN_INSTALL_DIR}

XB_APPLY_PATCH

# Filelist
# --------
# include/soxr-lsr.h
# include/soxr.h
# lib/libsoxr-lsr.a
# lib/pkgconfig/soxr.pc
# lib/pkgconfig/soxr-lsr.pc
# lib/libsoxr.a
# lib/libsoxr-lsr.so
# lib/libsoxr.so
# share/doc/libsoxr/NEWS
# share/doc/libsoxr/LICENCE
# share/doc/libsoxr/README
