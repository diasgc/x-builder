#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ clang
# GNU +++ +++  .   .  gcc
# WIN +++  .   .   .  clang/gcc

lib='guetzli'
dsc='Perceptual JPEG encoder'
lic='Apache-2.0'
src='https://github.com/google/guetzli.git'
cfg='cmake'
cstk='BUILD_STATIC_LIBS'
dep='libpng libjpeg'
eta='30'
pc_llib='-lguetzli'

lst_inc=''
lst_lib='libguetzli.*'
lst_bin='butteraugli'
lst_lic='LICENSE'
lst_pc=''

. xbuilder.sh

start

<<'XB_CREATE_CMAKELISTS'
cmake_minimum_required(VERSION 2.8.12)

project(guetzli CXX)
option(BUILD_STATIC_LIBS "Build static libs" ON)
option(BUILD_TOOLS "Build tools" ON)

add_definitions("-Wno-format")

find_package(ZLIB)
find_package(PNG)
find_package(JPEG)

include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/third_party/butteraugli ${ZLIB_INCLUDE_DIRS} ${PNG_INCLUDE_DIRS} ${JPEG_INCLUDE_DIRS})

file(GLOB_RECURSE src_guetzli guetzli/*.cc)
list(APPEND src_guetzli ${CMAKE_SOURCE_DIR}/third_party/butteraugli/butteraugli/butteraugli.cc)
file(GLOB_RECURSE hdr_guetzli guetzli/*.h)
list(APPEND hdr_guetzli ${CMAKE_SOURCE_DIR}/third_party/butteraugli/butteraugli/butteraugli.h)

set(guetzli_targets guetzli)
add_library(guetzli ${src_guetzli})
target_link_libraries(guetzli PUBLIC ${ZLIB_LIBRARIES} ${PNG_LIBRARIES} ${JPEG_LIBRARIES})

if(BUILD_SHARED_LIBS AND BUILD_STATIC_LIBS)
    add_library(guetzli_static STATIC ${src_guetzli})
    target_link_libraries(guetzli_static PRIVATE ${ZLIB_LIBRARIES} ${PNG_LIBRARIES} ${JPEG_LIBRARIES})
    set_target_properties(guetzli_static PROPERTIES OUTPUT_NAME guetzli)
    list(APPEND guetzli_targets guetzli_static)
endif()

if(BUILD_TOOLS)
    add_executable(butteraugli third_party/butteraugli/butteraugli/butteraugli_main.cc
         third_party/butteraugli/butteraugli/butteraugli.cc
         third_party/butteraugli/butteraugli/butteraugli.h)
    target_link_libraries(butteraugli guetzli)
endif()

install(TARGETS ${guetzli_targets}
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib${LIB_SUFFIX}
    LIBRARY DESTINATION lib${LIB_SUFFIX})

install(FILES ${hdr_guetzli} DESTINATION include/guetzli)

if(BUILD_TOOLS)
  install(TARGETS butteraugli RUNTIME DESTINATION bin)
endif()

XB_CREATE_CMAKELISTS

# Filelist
# --------
# include/gamma_correct.h
# include/jpeg_data_writer.h
# include/color_transform.h
# include/entropy_encode.h
# include/processor.h
# include/jpeg_data_decoder.h
# include/debug_print.h
# include/score.h
# include/jpeg_huffman_decode.h
# include/butteraugli.h
# include/fdct.h
# include/dct_double.h
# include/jpeg_data.h
# include/quantize.h
# include/jpeg_data_encoder.h
# include/preprocess_downsample.h
# include/jpeg_data_reader.h
# include/fast_log.h
# include/quality.h
# include/jpeg_bit_writer.h
# include/butteraugli_comparator.h
# include/output_image.h
# include/stats.h
# include/jpeg_error.h
# include/idct.h
# include/comparator.h
# lib/pkgconfig/guetzli.pc
# lib/libguetzli.so
# lib/libguetzli.a
# bin/butteraugli
