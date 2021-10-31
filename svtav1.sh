#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP+  .   .   .   clang
# GNU  .   .   .  PP++ gcc
# WIN  .   .   .   .   clang/gcc

lib='svtav1'
dsc='SVT (Scalable Video Technology) for AV1 encoder/decoder library'
lic='BSD'
src='https://github.com/OpenVisualCloud/SVT-AV1.git'
cfg='cmake'
pkg='SvtAv1Enc'
eta='45'
cbk="BUILD_APPS"

CFG="-DBUILD_TESTING=OFF"

. xbuilder.sh

[ "$host_os" == "android" ] && LDFLAGS+=" -L$SYSROOT/usr/${arch}/lib -llog"

start
<<'XB_APPLY_PATCH'
--- Source/Lib/Common/Codec/EbThreads.c	2021-10-30 17:52:28.635046300 +0100
+++ Source/Lib/Common/Codec/EbThreads.c	2021-10-30 17:51:13.195046300 +0100
@@ -81,7 +81,7 @@
     if (th == NULL)
         return NULL;
 
-#ifndef EB_THREAD_SANITIZER_ENABLED
+#if !defined EB_THREAD_SANITIZER_ENABLED && !defined(__ANDROID__)
     pthread_attr_t attr;
     pthread_attr_init(&attr);
     pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

--- Source/Lib/Common/Codec/EbThreads.h	2021-10-30 17:30:51.585046300 +0100
+++ Source/Lib/Common/Codec/EbThreads.h	2021-10-30 17:30:32.871000000 +0100
@@ -81,7 +81,7 @@
 #endif
 #include <sched.h>
 #include <pthread.h>
-#if defined(__linux__)
+#if defined(__linux__) && !defined(__ANDROID__)
 #define EB_CREATE_THREAD(pointer, thread_function, thread_context)                           \
     do {                                                                                     \
         pointer = svt_create_thread(thread_function, thread_context);                        \

--- CMakeLists.txt	2021-10-30 17:28:57.945046300 +0100
+++ CMakeLists.txt	2021-10-30 17:28:45.600000000 +0100
@@ -201,7 +201,9 @@
     else()
         check_both_flags_add(-fstack-protector-strong)
     endif()
-    check_both_flags_add(-mno-avx)
+    if (NOT CMAKE_C_COMPILER_ID STREQUAL "Clang")
+        check_both_flags_add(-mno-avx)
+    endif()
 endif()
 
 if(CMAKE_C_FLAGS MATCHES "-O" AND NOT CMAKE_C_FLAGS MATCHES "-O0" AND NOT MINGW)
XB_APPLY_PATCH


# Filelist
# --------
# include/svt-av1/EbDebugMacros.h
# include/svt-av1/EbSvtAv1Formats.h
# include/svt-av1/EbSvtAv1ExtFrameBuf.h
# include/svt-av1/EbSvtAv1Enc.h
# include/svt-av1/EbSvtAv1ErrorCodes.h
# include/svt-av1/EbSvtAv1Metadata.h
# include/svt-av1/EbSvtAv1.h
# include/svt-av1/EbSvtAv1Dec.h
# lib/pkgconfig/SvtAv1Enc.pc
# lib/pkgconfig/SvtAv1Dec.pc
# lib/libSvtAv1Dec.so
# lib/libSvtAv1Enc.so
# bin/SvtAv1DecApp
# bin/SvtAv1EncApp
