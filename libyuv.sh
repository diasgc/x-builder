#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libyuv'
dsc='Libyuv is an open source project that includes YUV scaling and conversion functionality'
lic='BSD-3c'
src='https://chromium.googlesource.com/libyuv/libyuv' sty='git'
cfg='cmake'
dep='libjpeg'
eta='0'
pc_llib='-lyuv'
pc_libsprivate='-lpthread -ljpeg'

#cshk=''
#cstk=''
#cbk=''

lst_inc='libyuv.h 
    libyuv/rotate_argb.h libyuv/macros_msa.h libyuv/scale.h libyuv/scale_argb.h 
    libyuv/convert_argb.h libyuv/compare_row.h libyuv/row.h libyuv/planar_functions.h 
    libyuv/scale_uv.h libyuv/scale_row.h libyuv/convert_from.h libyuv/version.h 
    libyuv/convert.h libyuv/cpu_id.h libyuv/convert_from_argb.h libyuv/mjpeg_decoder.h 
    libyuv/compare.h libyuv/rotate_row.h libyuv/rotate.h libyuv/basic_types.h 
    libyuv/video_common.h'
lst_lib='libyuv'
lst_bin='yuvconvert'

. xbuilder.sh

LDFLAGS+=" -ljpeg"

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-10-28 11:21:35.767000000 +0100
+++ CMakeLists.txt	2021-10-28 14:38:50.359546200 +0100
@@ -75,7 +75,7 @@
 
 
 # install the conversion tool, .so, .a, and all the header files
-INSTALL ( PROGRAMS ${CMAKE_BINARY_DIR}/yuvconvert			DESTINATION bin )
+INSTALL ( PROGRAMS ${CMAKE_BINARY_DIR}/yuvconvert${CMAKE_EXECUTABLE_SUFFIX}			DESTINATION bin )
 INSTALL ( TARGETS ${ly_lib_static}						DESTINATION lib )
 INSTALL ( TARGETS ${ly_lib_shared} LIBRARY				DESTINATION lib RUNTIME DESTINATION bin )
 INSTALL ( DIRECTORY ${PROJECT_SOURCE_DIR}/include/		DESTINATION include )

--- include/libyuv/version.h	2021-10-28 14:46:49.317000000 +0100
+++ include/libyuv/version.h	2021-10-28 14:46:55.559546200 +0100
@@ -13,4 +13,4 @@
 
 #define LIBYUV_VERSION 1801
 
-#endif  // INCLUDE_LIBYUV_VERSION_H_
\ No newline at end of file
+#endif  // INCLUDE_LIBYUV_VERSION_H_

XB_APPLY_PATCH

# Filelist
# --------
# include/libyuv.h
# include/libyuv/rotate_argb.h
# include/libyuv/macros_msa.h
# include/libyuv/scale.h
# include/libyuv/scale_argb.h
# include/libyuv/convert_argb.h
# include/libyuv/compare_row.h
# include/libyuv/row.h
# include/libyuv/planar_functions.h
# include/libyuv/scale_uv.h
# include/libyuv/scale_row.h
# include/libyuv/convert_from.h
# include/libyuv/version.h
# include/libyuv/convert.h
# include/libyuv/cpu_id.h
# include/libyuv/convert_from_argb.h
# include/libyuv/mjpeg_decoder.h
# include/libyuv/compare.h
# include/libyuv/rotate_row.h
# include/libyuv/rotate.h
# include/libyuv/basic_types.h
# include/libyuv/video_common.h
# lib/pkgconfig/libyuv.pc
# lib/libyuv.so
# lib/libyuv.a
# bin/yuvconvert
