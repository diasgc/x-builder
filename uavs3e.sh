#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .  PP  clang
# GNU  .   .   .  PP  gcc
# WIN  .   .   .  PP  clang/gcc

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

$host_x64 || doErr "Only for x86_64 cpus. $arch not supported."

start

<<'XB_APPLY_PATCH'
--- CMakeLists.old	2021-10-30 22:08:36.079000000 +0100
+++ CMakeLists.txt	2021-10-30 22:08:56.275046300 +0100
@@ -1,7 +1,7 @@
 cmake_minimum_required(VERSION 2.8)
 
 project(uavs3e)
-
+add_compile_options(-Wno-pointer-sign -Wno-unused-value -Wno-logical-not-parentheses -Wno-shift-negative-value -Wno-incompatible-pointer-types -Wno-constant-conversion)
 aux_source_directory(./test DIR_SRC_TEST)
 set_source_files_properties(${DIR_SRC_TEST} PROPERTIES COMPILE_FLAGS "${CMAKE_C_FLAGS}  -std=c99 -O3")

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

--- inc/com_system.h	2021-10-30 21:46:05.724000000 +0100
+++ inc/com_system.h	2021-10-30 21:46:19.505046300 +0100
@@ -161,7 +161,7 @@
 #define com_mset_x128(dst,v,size) memset((dst), (v), (size))
 #define com_mcmp(dst,src,size)    memcmp((dst), (src), (size))
 
-#if defined(__GNUC__)
+#if defined(__GNUC__) && !defined(__ANDROID__)
 #define offsetof(s,m) __builtin_offsetof(s,m)
 #endif

--- inc/com_thread.h	2021-10-30 22:05:17.475000000 +0100
+++ inc/com_thread.h	2021-10-30 22:06:31.845046300 +0100
@@ -23,7 +23,7 @@
 
 #else
 
-#pragma comment(lib, "pthreadVC2.lib")
+//#pragma comment(lib, "pthreadVC2.lib")
 
 #include <semaphore.h>
 #include <pthread.h>

XB_APPLY_PATCH

# Filelist
# --------
# include/uavs3e/uavs3e.h
# include/uavs3e/com_api.h
# lib/pkgconfig/uavs3e.pc
# lib/libuavs3e.so
