#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++ .   .  clang
# GNU +++ +++ .  +++ gcc
# WIN +++ .   .  +++ clang/gcc

lib='density'
dsc='Small & portable byte-aligned LZ77 compression'
lic='BSD-3c'
#vrs='0.14.2'
src='https://github.com/k0dai/density.git'
cfg='cmake'
eta='30'
pc_llib='-ldensity'
pc_url='https://github.com/k0dai/density'

. xbuilder.sh

CFG="-DBUILD_BENCHMARK=ON"

source_config(){
  cd $SRCDIR
  git submodule update --init --recursive
  cd ..
}

start

<<'XB_APPLY_PATCH'
--- CMakeLists.txt	2021-10-30 16:28:13.845046300 +0100
+++ CMakeLists.txt	2021-10-30 16:26:22.065046300 +0100
@@ -0,0 +1,46 @@
+cmake_minimum_required(VERSION 3.10)
+
+project(density C)
+
+option(BUILD_STATIC_LIBS "Build static libs" ON)
+option(BUILD_BENCHMARK "Build benchmark" OFF)
+
+add_compile_options("-Wno-format")
+
+file(GLOB_RECURSE SRC src/*.c)
+file(GLOB_RECURSE HDR src/*.h)
+
+if(BUILD_SHARED_LIBS)
+  add_library(density SHARED ${SRC})
+endif()
+
+if(BUILD_STATIC_LIBS)
+  add_library(density_static STATIC ${SRC})
+  set_target_properties(density_static PROPERTIES OUTPUT_NAME density)
+endif()
+
+if(BUILD_BENCHMARK)
+  file(GLOB_RECURSE src_cputime benchmark/libs/cputime/src/*.c)
+  add_library(cputime STATIC ${src_cputime})
+  file(GLOB_RECURSE src_spookyhash benchmark/libs/spookyhash/src/*.c)
+  add_library(spookyhash STATIC ${src_spookyhash})
+  add_executable(benchmark benchmark/src/benchmark.c)
+  target_link_libraries(benchmark density cputime spookyhash)
+endif()
+
+if(BUILD_SHARED_LIBS)
+  install(TARGETS density
+    RUNTIME DESTINATION bin
+    ARCHIVE DESTINATION lib${LIB_SUFFIX}
+    LIBRARY DESTINATION lib${LIB_SUFFIX})
+endif()
+
+if(BUILD_STATIC_LIBS)
+  install(TARGETS density_static ARCHIVE DESTINATION lib${LIB_SUFFIX})
+endif()
+
+install(FILES ${HDR} DESTINATION include)
+
+if(BUILD_BENCHMARK)
+  install(TARGETS benchmark RUNTIME DESTINATION bin)
+endif()
XB_APPLY_PATCH

# Filelist
# --------
# include/lion_encode.h
# include/globals.h
# include/algorithms.h
# include/buffer.h
# include/dictionaries.h
# include/lion_decode.h
# include/cheetah_encode.h
# include/lion.h
# include/lion_form_model.h
# include/chameleon_dictionary.h
# include/chameleon_encode.h
# include/cheetah.h
# include/cheetah_decode.h
# include/cheetah_dictionary.h
# include/lion_dictionary.h
# include/header.h
# include/chameleon_decode.h
# include/chameleon.h
# include/density_api.h
# lib/pkgconfig/density.pc
# lib/libdensity.a
# lib/libdensity.so
# bin/benchmark
