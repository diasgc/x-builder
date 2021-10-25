#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++  ++   .   .  clang
# GNU  .   .   .   .  gcc
# WIN ++   .   .  ++  clang/gcc

lib='vidstab'
apt='libvidstab-dev'
dsc='Vidstab is a video stabilization library which can be plugged-in with Ffmpeg and Transcode'
lic='GPL-2+'
src='https://github.com/georgmartius/vid.stab.git'
cfg='cmake'
eta='80'
lst_inc='vid.stab/vidstabdefines.h
	vid.stab/motiondetect_opt.h
	vid.stab/transformtype.h
	vid.stab/libvidstab.h
	vid.stab/vsvector.h
	vid.stab/motiondetect.h
	vid.stab/transform_internal.h
	vid.stab/transform.h
	vid.stab/transformtype_operations.h
	vid.stab/frameinfo.h
	vid.stab/motiondetect_internal.h
	vid.stab/serialize.h
	vid.stab/transformfixedpoint.h
	vid.stab/transformfloat.h
	vid.stab/localmotion2transform.h
	vid.stab/boxblur.h'
lst_lib='libvidstab'
lst_bin=''
CFG="-DUSE_OMP=OFF"

. xbuilder.sh

$host_arm && CFG+=" -DSSE2_FOUND=OFF"

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-10-10 18:24:33.433314400 +0100
+++ CMakeLists.txt	2021-10-10 18:25:13.623314400 +0100
@@ -16,7 +16,7 @@
 if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
   set(CMAKE_BUILD_TYPE "Release")
 endif()
-
+option(BUILD_STATIC_LIBS "build static libs" ON)
 option(BUILD_SHARED_LIBS "build shared libraries instead of static libraries"
        ON)
 
@@ -81,13 +81,25 @@
 set(PKG_EXTRA_LIBS "${PKG_EXTRA_LIBS} ${OpenMP_C_FLAGS}")
 endif()
 
-
+set(targets vidstab)
+if(BUILD_SHARED_LIBS AND BUILD_STATIC_LIBS)
+add_library (vidstab_static STATIC ${SOURCES})
+set_target_properties(vidstab_static PROPERTIES OUTPUT_NAME vidstab)
+target_link_libraries(vidstab_static m)
+list(APPEND targets vidstab_static)
+if(ORC_FOUND)
+target_link_libraries(vidstab_static ${ORC_LIBRARIES})
+endif()
+if(USE_OMP AND OPENMP_FOUND)
+target_link_libraries(vidstab_static OpenMP::OpenMP_C)
+endif()
+endif()
 #if(!NOHEADERS)
 FILE(GLOB HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h")
 INSTALL(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/vid.stab)
 #endif()
 
-INSTALL(TARGETS vidstab
+INSTALL(TARGETS ${targets}
   RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
   LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
   ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}

XB_APPLY_PATCH

# Filelist
# --------
# include/vid.stab/vidstabdefines.h
# include/vid.stab/motiondetect_opt.h
# include/vid.stab/transformtype.h
# include/vid.stab/libvidstab.h
# include/vid.stab/vsvector.h
# include/vid.stab/motiondetect.h
# include/vid.stab/transform_internal.h
# include/vid.stab/transform.h
# include/vid.stab/transformtype_operations.h
# include/vid.stab/frameinfo.h
# include/vid.stab/motiondetect_internal.h
# include/vid.stab/serialize.h
# include/vid.stab/transformfixedpoint.h
# include/vid.stab/transformfloat.h
# include/vid.stab/localmotion2transform.h
# include/vid.stab/boxblur.h
# lib/pkgconfig/vidstab.pc
# lib/libvidstab.a
# lib/libvidstab.so
