#!/bin/bash
#             a8  a7  x86 x64
# ndk-clang   +++ +++ ... +++
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libdeflate'
apt='libdeflate-dev'
dsc='Fast, whole-buffer DEFLATE-based compression and decompression'
lic='MIT'
src="https://github.com/ebiggers/libdeflate.git"
sty='git'
cfg='cmake'
eta='10'
pc_llib='-ldeflate'
lst_inc=''
lst_lib='libdeflate'
lst_bin=''
lst_oth=''

. xbuilder.sh
CBN="-DBUILD_SHARED_LIBS=ON"
start

<<'XB_CREATE_CMAKELISTS'
cmake_minimum_required(VERSION 3.10)

project(libdeflate C)
option(BUILD_STATIC_LIBS "Build static libs" ON)
option(BUILD_EXECUTABLES "Build executables" ON)
option(BUILD_TESTS "Build tests" CMAKE_OBJCXX_EXTENSIONS)
option(ENABLE_CRC "enable crc" ON)
option(ENABLE_CRYPTO "enable crypto" ON)

#option(INSTALL_MAN "Install man" OFF)
#option(INSTALL_DOCS "Install docs" OFF)
#add_compile_options("-Wno-shift-negative-value")

find_package(ZLIB)
include_directories(${CMAKE_SOURCE_DIR} common lib ${ZLIB_INCLUDE_DIRS})
file(GLOB src_deflate lib/*.c)
file(GLOB hdr_deflate libdeflate.h lib/*.h)

if(${CMAKE_SYSTEM_PROCESSOR} MATCHES "^arm")
  file(GLOB src_cpu lib/arm/*.c)
  file(GLOB hdr_cpu lib/arm/*.h)
  if(ENABLE_CRC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcrc")
  endif()
  #if(ENABLE_CRYPTO)
  #  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfpu=crypto-neon-fp-armv8")
  #endif()
elseif(${CMAKE_SYSTEM_PROCESSOR} MATCHES "^a.*64$")
  file(GLOB src_cpu lib/arm/*.c)
  file(GLOB hdr_cpu lib/arm/*.h)
  if(ENABLE_CRC)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv8-a+crc")
  endif()
  if(ENABLE_CRYPTO)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv8-a+crypto")
  endif()
else()
  file(GLOB src_cpu lib/x86/*.c)
  file(GLOB hdr_cpu lib/x86/*.h)
endif()

if(BUILD_SHARED_LIBS)
  add_library(deflate SHARED ${src_deflate} ${hdr_deflate} ${src_cpu} ${hdr_cpu})
endif()

if(BUILD_STATIC_LIBS)
  add_library(deflate_static STATIC ${src_deflate} ${hdr_deflate} ${src_cpu} ${hdr_cpu})
  set_target_properties(deflate_static PROPERTIES OUTPUT_NAME deflate)
endif()

if(BUILD_EXECUTABLES)
  add_executable(gzip programs/gzip.c programs/tgetopt.c 
    programs/test_util.c programs/test_util.h
    programs/prog_util.c programs/prog_util.h
    )
  target_link_libraries(gzip deflate ${ZLIB_LIBRARIES})
endif()

if(BUILD_TESTS)
  add_executable(benchmark programs/benchmark.c programs/tgetopt.c
    programs/test_util.c programs/test_util.h
    programs/checksum.c programs/test_checksums.c programs/test_custom_malloc.c programs/test_incomplete_codes.c
    programs/test_litrunlen_overflow.c programs/test_slow_decompression.c programs/test_trailing_bytes.c
    )
  target_link_libraries(benchmark deflate ${ZLIB_LIBRARIES})
endif()

if(BUILD_SHARED_LIBS)
  install(TARGETS deflate
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib${LIB_SUFFIX}
    LIBRARY DESTINATION lib${LIB_SUFFIX})
endif()

if(BUILD_STATIC_LIBS)
  install(TARGETS deflate_static ARCHIVE DESTINATION lib${LIB_SUFFIX})
endif()

install(FILES libdeflate.h DESTINATION include)

if(BUILD_EXECUTABLES)
  install(TARGETS gzip RUNTIME DESTINATION bin)
endif()

if(BUILD_TESTS)
  install(TARGETS benchmark RUNTIME DESTINATION bin)
endif()
XB_CREATE_CMAKELISTS


# Filelist
# --------
# include/libdeflate.h
# lib/pkgconfig/libdeflate.pc
# lib/libdeflate.so
# lib/libdeflate.a
# bin/gzip
