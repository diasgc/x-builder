#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++  .   .  clang
# GNU +++  .   .   .  gcc
# WIN +++  .   .   .  clang/gcc
# warning: Warning static builds of getopt violate the Lesser GNU Public License

lib='flif'
dsc='Free Lossless Image Format'
lic='BSD-2c Apache-2.0 GPL-2.0 LGPL-2.1'
src='https://github.com/FLIF-hub/FLIF.git'
cfg='cmake'
dep='libpng'
eta='60'

lst_inc='flif_dec.h flif_enc.h flif.h flif_common.h'
lst_lib='libflif libflif_dec'
lst_bin='flif apng2flif gif2flif dflif'
lst_lic='share/licenses/FLIF/LICENSE_Apache2
    share/licenses/FLIF/LICENSE
    share/licenses/FLIF/LICENSE_GPL
    share/licenses/FLIF/LICENSE_LGPL
    share/licenses/FLIF/FLIF-CLA-template.txt'

req_pcforlibs=$lst_lib
dir_config='src'

. xbuilder.sh

CPPFLAGS="-Wno-sign-compare -Wno-type-limits $CPPFLAGS"
HOST_NPROC=16

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-10-09 14:39:20.783000000 +0100
+++ CMakeLists.txt	2021-10-09 14:41:14.801780300 +0100
@@ -5,6 +5,7 @@
 include(FindPkgConfig)
 find_package(PNG REQUIRED)
 include_directories(${PNG_INCLUDE_DIRS})
+option(USE_SDL "Use SDL" OFF)
 option(BUILD_SHARED_LIBS "Build shared FLIF encoder/decoder libraries" ON)
 option(BUILD_STATIC_LIBS "Build static FLIF encoder/decoder libraries" ON)
 
@@ -12,6 +13,7 @@
 # find SDL2
 
 find_package(PkgConfig QUIET)
+if (USE_SDL)
 pkg_check_modules(PKG_SDL2 QUIET sdl2)
 
 find_path(SDL2_INCLUDE_DIR
@@ -38,6 +40,8 @@
   PATH_SUFFIXES x64 x86
 )
 
+endif(USE_SDL)
+
 include(FindPackageHandleStandardArgs)
 find_package_handle_standard_args(SDL2
                                   REQUIRED_VARS SDL2_INCLUDE_DIR SDL2_LIBRARY SDL2MAIN_LIBRARY)
--- image/crc32k.hpp	2021-10-09 15:35:37.121780300 +0100
+++ image/crc32k.hpp	2021-10-09 20:01:28.768086800 +0100
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 
 // define endianess and some integer data types
-#if defined(_MSC_VER) || defined(__MINGW32__)
+#if defined(_MSC_VER) || defined(__MINGW32__) && defined(__amd64__)
   typedef unsigned __int8  uint8_t;
   typedef unsigned __int16 uint16_t;
   typedef unsigned __int32 uint32_t;
XB_APPLY_PATCH

# Filelist
# --------
# include/flif_dec.h
# include/flif_enc.h
# include/flif.h
# include/flif_common.h
# lib/pkgconfig/flif_dec.pc
# lib/pkgconfig/flif.pc
# lib/libflif.so.0
# lib/libflif.a
# lib/libflif_dec.a
# lib/libflif_dec.so.0
# share/FLIF/flif.magic
# share/man/man1/flif.1
# share/mime/packages/flif-mime.xml
# share/licenses/FLIF/LICENSE_Apache2
# share/licenses/FLIF/LICENSE
# share/licenses/FLIF/LICENSE_GPL
# share/licenses/FLIF/LICENSE_LGPL
# share/licenses/FLIF/FLIF-CLA-template.txt
# bin/flif
# bin/apng2flif
# bin/gif2flif
# bin/dflif
