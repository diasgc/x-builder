#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +F+ +F+ +F+ ... CLANG
# GNU +++ ... ... +F+ GCC
# WIN ... ... ... +.+ CLANG/GCC

lib='sjpeg'
dsc='SimpleJPEG: simple jpeg encoder'
lic='Apache2.0'
src='https://github.com/webmproject/sjpeg.git' src_opt="--recursive"
cfg='cmake'
eta='20'
dep='libjpeg libpng'
pc_llib='-lsjpeg'
lst_inc='sjpeg.h'
lst_lib='libsjpeg'
lst_bin='vjpeg sjpeg'

. xbuilder.sh

CFG="-DSJPEG_ANDROID_NDK_PATH=${ANDROID_NDK_HOME}"

start


<<'XB_PATCH_CMAKELISTS'
--- CMakeLists.old	2021-10-11 22:44:05.047000000 +0100
+++ CMakeLists.txt	2021-10-11 22:59:03.310000000 +0100
@@ -22,6 +22,7 @@
 # Options for coder / decoder executables.
 option(SJPEG_ENABLE_SIMD "Enable any SIMD optimization." ON)
 option(SJPEG_BUILD_EXAMPLES "Build the sjpeg / vjpeg command line tools." ON)
+option(SJPEG_INSTALL_MANPAGE "Build man page" OFF)
 
 set(SJPEG_DEP_LIBRARIES)
 set(SJPEG_DEP_INCLUDE_DIRS)
@@ -129,6 +130,8 @@
 if(WIN32)
   # quiet warnings related to fopen, sscanf
   target_compile_definitions(utils PRIVATE _CRT_SECURE_NO_WARNINGS)
+else()
+  set_target_properties(utils PROPERTIES POSITION_INDEPENDENT_CODE ON)
 endif()
 if(SJPEG_HAVE_OPENGL)
   # check pthread for GL libraries
@@ -156,7 +159,7 @@
   target_link_libraries(utils ${SJPEG_DEP_IMG_LIBRARIES}
                         ${SJPEG_DEP_GL_LIBRARIES})
 endif()
-# set_target_properties(utils PROPERTIES POSITION_INDEPENDENT_CODE ON)
+
 
 # Build the executables if asked for.
 if(SJPEG_BUILD_EXAMPLES)
@@ -226,6 +229,8 @@
 
 ################################################################################
 # Man page.
+if(SJPEG_INSTALL_MANPAGE)
 install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/man/sjpeg.1
               ${CMAKE_CURRENT_SOURCE_DIR}/man/vjpeg.1
   DESTINATION ${CMAKE_INSTALL_MANDIR}/man1)
+endif()

XB_PATCH_CMAKELISTS

# Filelist
# --------
# include/sjpeg.h
# lib/pkgconfig/sjpeg.pc
# lib/libsjpeg.a
# share/sjpeg/cmake/sjpegConfigVersion.cmake
# share/sjpeg/cmake/sjpegConfig.cmake
# bin/vjpeg
# bin/sjpeg
