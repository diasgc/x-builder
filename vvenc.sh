#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+ -/+  .   .   .   .   X   X   X   .   .  static
# +/- +/-  .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

lib='vvenc'
pkg='libvvenc'
dsc='Fraunhofer Versatile Video Encoder'
lic='LGPL-2.1'
src='https://github.com/fraunhoferhhi/vvenc.git'
sty='git'
cfg='cm'
eta='480'
cbk="BUILD_TOOLS"

mkinstall='all'

. xbuilder.sh

case $arch in
  aarch64*|arm*) CFG="-DVVENC_ENABLE_X86_SIMD=FALSE -DVVENC_ENABLE_ARM_SIMD=TRUE";;
esac

_source_patch(){
  sed -i 's/set( VVENC_ENABLE_X86_SIMD/option( VVENC_ENABLE_X86_SIMD/' $SRCDIR/CMakeLists.txt
  sed -i 's/set( VVENC_ENABLE_ARM_SIMD/option( VVENC_ENABLE_ARM_SIMD/' $SRCDIR/CMakeLists.txt
  sed -i '$!N;s/^.*\n.*malloc_trim/#if defined( __linux__ ) \&\& \!defined(__ANDROID__)\n  malloc_trim/;P;D' $SRCDIR/source/Lib/vvenc/vvencimpl.cpp
}

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-10-08 16:12:02.198000000 +0100
+++ CMakeLists.txt	2021-10-08 16:12:41.200000000 +0100
@@ -12,8 +12,8 @@
 # project name
 project( vvenc VERSION 1.1.0 )
 
-set( VVENC_ENABLE_X86_SIMD TRUE )
-set( VVENC_ENABLE_ARM_SIMD FALSE )
+option( VVENC_ENABLE_X86_SIMD "enable x86 intrinsics" TRUE)
+option( VVENC_ENABLE_ARM_SIMD "enable arm intrinsics" FALSE )
 
 if( APPLE )
   if( DEFINED CMAKE_OSX_ARCHITECTURES )

--- source/Lib/vvenc/vvencimpl.old	2021-10-08 16:14:22.700000000 +0100
+++ source/Lib/vvenc/vvencimpl.cpp	2021-10-08 16:19:42.480000000 +0100
@@ -235,7 +235,7 @@
 #endif
   }
 
-#if defined( __linux__ )
+#if defined( __linux__ ) && !defined(__ANDROID__)
   malloc_trim(0);   // free unused heap memory
 #endif
 
@@ -403,7 +403,7 @@
     iRet = xCopyAu( *pcAccessUnit, cAu  );
   }
 
-#if defined( __linux__ )
+#if defined( __linux__ ) && !defined(__ANDROID__)
   malloc_trim(0);   // free unused heap memory
 #endif

XB_APPLY_PATCH

# Filelist
# --------
# include/vvenc/vvencDecl.h
# include/vvenc/vvenc.h
# include/vvenc/version.h
# include/vvenc/vvencCfg.h
# lib/pkgconfig/libvvenc.pc
# lib/cmake/vvenc/vvencConfig.cmake
# lib/cmake/vvenc/vvencTargets-shared-release.cmake
# lib/cmake/vvenc/vvencConfigVersion.cmake
# lib/cmake/vvenc/vvencTargets-shared.cmake
# lib/libvvenc.so
# bin/vvencapp
# bin/vvencFFapp
