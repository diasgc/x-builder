#!/bin/bash

#     Aa8 Aa7 A86 A64
# NDK +++ +++ +++ +++ clang
# GNU +++  .   .   .  gcc
# WIN +++  .   .  +++ clang/gcc

lib='x265'
dsc='x265 is an open source HEVC encoder'
lic='GPL-2.0'
src='https://github.com/videolan/x265.git'
cfg='cmake'
tls='yasm libnuma-dev'
eta='360'
cbk="ENABLE_CLI"
dir_config='source'
cshk='ENABLE_SHARED'
CFG='-DHIGH_BIT_DEPTH=ON'

lst_inc='x265.h x265_config.h'
lst_lib='libx265'
lst_bin='x265'
lst_oth=''

. xbuilder.sh

$build_bin && CFG+=" -DSTATIC_LINK_CRT=ON"
$build_shared && CSH="-DENABLE_SHARED=ON" || CSH="-DENABLE_SHARED=OFF"
[ "$host_os" == "mingw32" ] && CFG+=" -DENABLE_PIC=OFF"
$host_arm && CFG+=" -DCROSS_COMPILE_ARM=ON -DENABLE_ASSEMBLY=OFF" || CFG+=" -DCMAKE_ASM_NASM_FLAGS=-w-macro-params-legacy"

start

#cpu patch for arm-mingw archs
<<'XB_PATCH_CMAKELISTS'
--- source/CMakeLists.old	2021-10-10 18:46:32.455000000 +0100
+++ source/CMakeLists.txt	2021-10-10 18:52:19.083314400 +0100
@@ -219,9 +219,9 @@
     else()
         add_definitions(-std=gnu++98)
     endif()
-    if(ENABLE_PIC)
+    if(NOT WIN32 AND ENABLE_PIC)
          add_definitions(-fPIC)
-    endif(ENABLE_PIC)
+    endif()
     if(NATIVE_BUILD)
         if(INTEL_CXX)
             add_definitions(-xhost)
@@ -238,21 +238,25 @@
             endif()
         endif()
     endif()
+    set(PIC "")
+    if(NOT WIN32)
+        set(PIC -fPIC)
+    endif()
     if(ARM AND CROSS_COMPILE_ARM)
         if(ARM64)
-            set(ARM_ARGS -fPIC)
+            set(ARM_ARGS ${PIC})
         else()
-            set(ARM_ARGS -march=armv6 -mfloat-abi=soft -mfpu=vfp -marm -fPIC)
+            set(ARM_ARGS -march=armv6 -mfloat-abi=soft -mfpu=vfp -marm ${PIC})
         endif()
         message(STATUS "cross compile arm")
     elseif(ARM)
         if(ARM64)
-            set(ARM_ARGS -fPIC)
+            set(ARM_ARGS ${PIC})
             add_definitions(-DHAVE_NEON)
         else()
             find_package(Neon)
             if(CPU_HAS_NEON)
-                set(ARM_ARGS -mcpu=native -mfloat-abi=hard -mfpu=neon -marm -fPIC)
+                set(ARM_ARGS -mcpu=native -mfloat-abi=hard -mfpu=neon -marm ${PIC})
                 add_definitions(-DHAVE_NEON)
             else()
                 set(ARM_ARGS -mcpu=native -mfloat-abi=hard -mfpu=vfp -marm)

--- source/common/cpu.old	2021-10-10 19:20:39.163314400 +0100
+++ source/common/cpu.cpp	2021-10-10 19:20:37.723314400 +0100
@@ -39,7 +39,7 @@
 #include <machine/cpu.h>
 #endif
 
-#if X265_ARCH_ARM && !defined(HAVE_NEON)
+#if X265_ARCH_ARM && !defined(HAVE_NEON) && !defined(__WIN32__)
 #include <signal.h>
 #include <setjmp.h>
 static sigjmp_buf jmpbuf;

XB_PATCH_CMAKELISTS

# Filelist
# --------
# include/x265.h
# include/x265_config.h
# lib/pkgconfig/x265.pc
# lib/libx265.so
# lib/libx265.a
# bin/x265
