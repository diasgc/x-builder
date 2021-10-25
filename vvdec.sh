#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='vvdec'
pkg='libvvdec'
dsc='Fraunhofer Versatile Video Decoder (VVdeC)'
lic='LGPL-2.1'
src='https://github.com/fraunhoferhhi/vvdec.git'
cfg='cmake'
eta='480'
cbk="BUILD_TOOLS"
mki='all'

. xbuilder.sh

lst_inc=''
lst_lib=''
lst_bin=''

$host_arm && CFG="-DVVDEC_ENABLE_X86_SIMD=FALSE -DVVDEC_ENABLE_ARM_SIMD=TRUE"

_source_patch(){
  sed -i 's/^set( VVDEC_ENABLE_X86_SIMD/option( VVDEC_ENABLE_X86_SIMD/' $SRCDIR/CMakeLists.txt
  sed -i 's/^set( VVDEC_ENABLE_ARM_SIMD/option( VVDEC_ENABLE_ARM_SIMD/' $SRCDIR/CMakeLists.txt
  sed -i '$!N;s/^.*\n.*malloc_trim/#if defined( __linux__ ) \&\& \!defined(__ANDROID__)\n  malloc_trim/;P;D' $SRCDIR/source/Lib/vvdec/vvdecimpl.cpp
}

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-10-08 15:19:13.053000000 +0100
+++ CMakeLists.txt	2021-10-08 15:35:29.110000000 +0100
@@ -12,8 +12,8 @@
 # project name
 project( vvdec VERSION 1.2.0 )
 
-set( VVDEC_ENABLE_X86_SIMD TRUE  CACHE BOOL "enable x86 intrinsics" )
-set( VVDEC_ENABLE_ARM_SIMD FALSE CACHE BOOL "enable arm intrinsics" )
+option( VVDEC_ENABLE_X86_SIMD "enable x86 intrinsics" TRUE)
+option( VVDEC_ENABLE_ARM_SIMD "enable arm intrinsics" FALSE )
 
 if( APPLE )
   if( DEFINED CMAKE_OSX_ARCHITECTURES )

--- source/Lib/vvdec/vvdecimpl.cpp	2021-10-08 15:50:58.542000000 +0100
+++ source/Lib/vvdec/vvdecimpl.cpp	2021-10-08 15:51:28.190000000 +0100
@@ -190,7 +190,7 @@
   delete m_cDecLib;
   destroyROM();
 
-#if defined( __linux__ )
+#if defined( __linux__ ) && !defined(__ANDROID__)
   malloc_trim(0);
 #endif

XB_APPLY_PATCH

# Filelist
# --------
# include/vvdec/sei.h
# include/vvdec/vvdec.h
# include/vvdec/version.h
# include/vvdec/vvdecDecl.h
# lib/pkgconfig/libvvdec.pc
# lib/cmake/vvdec/vvdecConfigVersion.cmake
# lib/cmake/vvdec/vvdecTargets-static.cmake
# lib/cmake/vvdec/vvdecTargets-static-release.cmake
# lib/cmake/vvdec/vvdecConfig.cmake
# lib/libvvdec.a
# bin/vvdecapp
