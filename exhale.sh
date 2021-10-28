#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++  .   .  clang
# GNU +++  .   .   .  gcc
# WIN +++ +++  .  +++ clang/gcc

lib='exhale'
apt=''
dsc='an open-source ISO/IEC 23003-3 (USAC, xHE-AAC) encoder'
lic='Copyright'
src='https://gitlab.com/ecodis/exhale.git'
cfg='cmake'
eta='150'
pc_llib="-lexhale"

. xbuilder.sh

CFG="-DBUILD_TESTS=OFF -DCMAKE_DL_LIBS=ON"

start

<<'XB_APPLY_PATCH'
--- src/lib/CMakeLists.txt	2021-10-07 15:53:38.150000000 +0100
+++ src/lib/CMakeLists.txt	2021-10-07 16:08:33.300000000 +0100
@@ -7,51 +7,39 @@
  #
  # Copyright (c) 2018-2021 Christian R. Helmrich, project ecodis. All rights reserved.
  ##
-
-add_library(exhaleLib
-    lappedTransform.cpp
-    exhaleLibPch.cpp
-    bitStreamWriter.cpp
-    quantization.cpp
-    stereoProcessing.h
-    exhaleLibPch.h
-    entropyCoding.cpp
-    tempAnalysis.cpp
-    bitAllocation.cpp
-    stereoProcessing.cpp
-    bitAllocation.h
-    bitStreamWriter.h
-    specAnalysis.h
-    specAnalysis.cpp
-    lappedTransform.h
-    specGapFilling.cpp
-    specGapFilling.h
-    linearPrediction.h
-    quantization.h
-    entropyCoding.h
-    exhaleEnc.cpp
-    tempAnalysis.h
-    linearPrediction.cpp
-    exhaleEnc.h
+file(GLOB src_exhale
+    *.cpp
+    *.h
     ${PROJECT_SOURCE_DIR}/include/exhaleDecl.h
     ${PROJECT_SOURCE_DIR}/include/version.h)
 
-set_target_properties(exhaleLib PROPERTIES OUTPUT_NAME exhale)
-
-if(TARGET Threads::Threads)
-    target_link_libraries(exhaleLib PRIVATE Threads::Threads)
-endif()
-if(CMAKE_DL_LIBS)
-    target_link_libraries(exhaleLib PRIVATE ${CMAKE_DL_LIBS})
+if(BUILD_SHARED_LIBS)
+    set(TARGETS exhaleLib exhaleLib-static)
+    add_library(exhaleLib SHARED ${src_exhale})
+    add_library(exhaleLib-static STATIC ${src_exhale})
+else()
+    set(TARGETS exhaleLib)
+    add_library(exhaleLib ${src_exhale})
 endif()
-target_include_directories(exhaleLib PRIVATE ${PROJECT_SOURCE_DIR}/include)
 
-# PCH requires at least 3.16
-# I actually don't know if this works or not
-if(CMAKE_VERSION VERSION_GREATER "3.16.0")
-    target_precompile_headers(exhaleLib PUBLIC ${PROJECT_SOURCE_DIR}/src/lib/exhaleLibPch.h)
-endif()
+foreach(target ${TARGETS})
+    set_target_properties(${target} PROPERTIES OUTPUT_NAME exhale)
+
+    if(TARGET Threads::Threads)
+        target_link_libraries(${target} PRIVATE Threads::Threads)
+    endif()
+    if(CMAKE_DL_LIBS)
+        target_link_libraries(${target} PRIVATE ${CMAKE_DL_LIBS})
+    endif()
+    target_include_directories(${target} PRIVATE ${PROJECT_SOURCE_DIR}/include)
+
+    # PCH requires at least 3.16
+    # I actually don't know if this works or not
+    if(CMAKE_VERSION VERSION_GREATER "3.16.0")
+        target_precompile_headers(${target} PUBLIC ${PROJECT_SOURCE_DIR}/src/lib/exhaleLibPch.h)
+    endif()
+endforeach(target ${TARGETS})
 
-install(TARGETS exhaleLib
+install(TARGETS ${TARGETS}
     ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
     LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})

--- src/app/CMakeLists.txt	2021-10-07 16:57:22.950000000 +0100
+++ src/app/CMakeLists.txt	2021-10-07 16:57:21.330000000 +0100
@@ -31,7 +31,13 @@
 if(CMAKE_DL_LIBS)
     target_link_libraries(exhaleApp PRIVATE ${CMAKE_DL_LIBS})
 endif()
-target_link_libraries(exhaleApp PRIVATE exhaleLib)
+
+if(BUILD_SHARED_LIBS)
+target_link_libraries(exhaleApp PRIVATE exhaleLib-static)
+else()
+target_link_libraries(exhaleApp PRIVATE exhaleLib)
+endif()
+
 target_include_directories(exhaleApp PRIVATE ${PROJECT_SOURCE_DIR}/include)
 
 # PCH requires at least 3.16

--- src/app/exhaleApp.rc	2021-10-07 17:57:15.710000000 +0100
+++ src/app/exhaleApp.rc	2021-10-07 17:57:14.170000000 +0100
@@ -8,7 +8,7 @@
  * Copyright (c) 2018-2021 Christian R. Helmrich, project ecodis. All rights reserved.
  */
 
-#include "..\..\include\version.h" // for EXHALELIB_VERSION_... strings
+#include "../../include/version.h" // for EXHALELIB_VERSION_... strings
 #include <windows.h>
 
 0 ICON "exhaleApp.ico"

XB_APPLY_PATCH


# Filelist
# --------
# lib/pkgconfig/exhale.pc
# lib/libexhale.so
# lib/libexhale.a
# bin/exhale
