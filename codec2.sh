#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++o ++o +++ ++o
# linux-gnu   ... ... ... ...
# mingw-llvm  ++o ... ... ...

lib='codec2'
apt='libcodec2-0.9'
dsc='A speech codec for 2400 bit/s and below'
#vrs='1.0.0'
lic='LGPL-2.1'
src='https://github.com/drowe67/codec2.git'
cfg='cmake'
eta='80'

lst_inc='codec2/modem_stats.h codec2/codec2_cohpsk.h codec2/fsk.h \
         codec2/codec2_fdmdv.h codec2/codec2_ofdm.h codec2/comp.h \
         codec2/codec2_fifo.h codec2/version.h codec2/freedv_api.h \
         codec2/codec2.h codec2/codec2_fm.h codec2/reliable_text.h'
lst_lib='libcodec2'
lst_bin=''
lst_oth=''

. xbuilder.sh

CFG="-DUNITTEST=FALSE"
unset LDFLAGS

build_patch_config(){
    $host_mingw && {
        sed -i "s|include|# include|" $BUILD_DIR/cmake/GetDependencies.cmake
        sed -i "s|get_prerequisites|# get_prerequisites|" $BUILD_DIR/cmake/GetDependencies.cmake
    }
}

start

<<'XB_APPLY_PATCH'
--- src/CMakeLists.bak	2021-09-26 11:40:43.625147200 +0100
+++ src/CMakeLists.txt	2021-09-26 12:51:15.365147200 +0100
@@ -71,6 +71,7 @@
        BUILD_COMMAND ${CMAKE_COMMAND} --build . --target generate_codebook
        INSTALL_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/codec2_native/src/generate_codebook ${CMAKE_CURRENT_BINARY_DIR}
        BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/generate_codebook
+       CMAKE_ARGS -DCMAKE_C_COMPILER=gcc
     )
     add_executable(generate_codebook IMPORTED)
     set_target_properties(generate_codebook PROPERTIES
@@ -238,6 +239,28 @@
 #
 # Setup the codec2 library
 #
+
+add_compile_options("-Wno-implicit-const-int-float-conversion")
+
+set(TARGETS codec2)
+
+if(BUILD_STATIC_LIBS AND BUILD_SHARED_LIBS)
+    add_library(codec2_static STATIC ${CODEC2_SRCS})
+    set_target_properties(codec2_static PROPERTIES OUTPUT_NAME codec2)
+    target_include_directories(codec2_static INTERFACE
+        $<INSTALL_INTERFACE:include/codec2>
+        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
+        $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
+    )
+    if(UNIX)
+        target_link_libraries(codec2_static m)
+    endif(UNIX)
+    if(LPCNET AND lpcnetfreedv_FOUND)
+        target_link_libraries(codec2_static lpcnetfreedv)
+    endif()
+    list(APPEND TARGETS codec2_static)
+endif()
+
 add_library(codec2 ${CODEC2_SRCS})
 if(UNIX)
     target_link_libraries(codec2 m)
@@ -393,7 +416,7 @@
 add_executable(ldpc_dec ldpc_dec.c)
 target_link_libraries(ldpc_dec ${CMAKE_REQUIRED_LIBRARIES} codec2)
 
-install(TARGETS codec2 EXPORT codec2-config
+install(TARGETS ${TARGETS} EXPORT codec2-config
     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT lib
     ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT lib
     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
XB_APPLY_PATCH


# Filelist
# --------
# include/codec2/modem_stats.h
# include/codec2/codec2_cohpsk.h
# include/codec2/fsk.h
# include/codec2/codec2_fdmdv.h
# include/codec2/codec2_ofdm.h
# include/codec2/comp.h
# include/codec2/codec2_fifo.h
# include/codec2/version.h
# include/codec2/freedv_api.h
# include/codec2/codec2.h
# include/codec2/codec2_fm.h
# include/codec2/reliable_text.h
# lib/pkgconfig/codec2.pc
# lib/libcodec2.a
# lib/libcodec2.so
# lib/cmake/codec2/codec2-config.cmake
# lib/cmake/codec2/codec2-config-release.cmake