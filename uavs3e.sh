#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  F   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .  PP+ clang/gcc

lib='uavs3e'
dsc='AVS3 encoder which supports AVS3-P2 baseline profile.'
lic='Other'
src='https://github.com/uavs3/uavs3e.git'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start

<<'XB_APPLY_PATCH'
--- src/CMakeLists.old	2021-10-18 01:06:17.763176300 +0100
+++ src/CMakeLists.txt	2021-10-18 01:06:16.193176300 +0100
@@ -10,9 +10,12 @@
 
 include_directories("../inc")
 
-set_source_files_properties(${DIR_UAVS3E_SRC} PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -std=c99 -O3")
-set_source_files_properties(${DIR_X86_SRC} PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -std=c99 -O3 -msse4.2")
-set_source_files_properties(${DIR_X86_256_SRC} PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS} -fPIC -std=c99 -O3 -mavx2")
+if(NOT WIN32)
+  set(FPIC "-fPIC")
+endif()
+set_source_files_properties(${DIR_UAVS3E_SRC} PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS} ${FPIC} -std=c99 -O3")
+set_source_files_properties(${DIR_X86_SRC} PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS} ${FPIC} -std=c99 -O3 -msse4.2")
+set_source_files_properties(${DIR_X86_256_SRC} PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS} ${FPIC} -std=c99 -O3 -mavx2")
 
 # get version
 set (CONFIG_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)

XB_APPLY_PATCH