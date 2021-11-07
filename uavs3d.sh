#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP  PP   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='uavs3d'
dsc='AVS3 decoder which supports AVS3-P2 baseline profile.'
lic='Other'
src='https://github.com/uavs3/uavs3d.git'
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
--- source/CMakeLists.txt	2021-10-30 20:05:40.218000000 +0100
+++ source/CMakeLists.txt	2021-10-30 20:06:24.265046300 +0100
@@ -43,17 +43,17 @@
   list(APPEND UAVS3D_ASM_FILES ${DIR_X86_SRC})
   list(APPEND UAVS3D_ASM_FILES ${DIR_X86_256_SRC})
 elseif("${UAVS3D_TARGET_CPU}" MATCHES "armv7")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/armv7.c")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/alf_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/deblock_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/def_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/inter_pred_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/intra_pred_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/dct2_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/itrans_dct8_dst7_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/pixel_armv7.S")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/sao_armv7.c")
-  list(APPEND UAVS3D_ASM_FILES "./decore/arm64/sao_kernel_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/armv7.c")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/alf_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/deblock_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/def_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/inter_pred_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/intra_pred_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/dct2_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/itrans_dct8_dst7_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/pixel_armv7.S")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/sao_armv7.c")
+  list(APPEND UAVS3D_ASM_FILES "./decore/armv7/sao_kernel_armv7.S")
 
   add_definitions(-D _armv7a)
   enable_language(ASM)

--- source/decore/threadpool.o	2021-10-30 20:09:25.057000000 +0100
+++ source/decore/threadpool.h	2021-10-30 20:09:39.625046300 +0100
@@ -12,7 +12,7 @@
 #include "win32thread.h"
 #else
 
-#pragma comment(lib, "pthreadVC2.lib")
+//#pragma comment(lib, "pthreadVC2.lib")
 
 #include <pthread.h>
 #define uavs3d_pthread_t                pthread_t

XB_APPLY_PATCH

# Filelist
# --------
# include/uavs3d.h
# lib/pkgconfig/uavs3d.pc
# lib/libuavs3d.so
