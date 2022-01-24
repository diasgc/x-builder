#!/bin/bash
#             a8  a7  x86 x64
# ndk-clang   +++ +++ +++ +++
# linux-gnu    F  +++ ... ...
# mingw-llvm   F   F  ... ...

lib='jxrlib'
pkg='libjxr'
dsc='JPEG XR Image Codec reference implementation library released by Microsoft'
lic='BSD-2c'
src='https://github.com/4creators/jxrlib.git'
cfg='cmake'
cbk='BUILD_EXECUTABLES'
cstk='BUILD_STATIC_LIBS'

pc_llib='-ljpegxr -jxrglue'

lst_inc='libjxr/glue/*.h libjxr/image/*.h libjxr/common/*.h libjxr/test/*.h'
lst_lib='libjpegxr.* libjxrglue.*'
lst_bin='JxrEncApp JxrDecApp'
lst_lic='LICENSE AUTHORS'
lst_pc='jpegxr.pc xrglue.pc'

. xbuilder.sh

WFLAGS="-Wno-implicit-int -Wno-endif-labels"

start

<<'XB_CREATE_CMAKELISTS'
cmake_minimum_required(VERSION 2.8)
project(jxrlib C)

set(JXRLIB_MAJOR 0)
set(JXRLIB_MINOR 0)

set(JXRLIB_LIB_VERSION ${JXRLIB_MAJOR}.${JXRLIB_MINOR}.0)
set(JXRLIB_SO_VERSION ${JXRLIB_MAJOR})

include(TestBigEndian)
test_big_endian(ISBIGENDIAN)
if(ISBIGENDIAN)
  set(DEF_ENDIAN -D_BIG__ENDIAN_)
endif()

add_definitions(-D__ANSI__ -DDISABLE_PERF_MEASUREMENT ${DEF_ENDIAN})

include_directories(
  common/include
  image/sys
  jxrgluelib
  jxrtestlib
)

# JXR Library
file(GLOB jpegxr_SRC image/sys/*.c image/decode/*.c image/encode/*.c)
file(GLOB jpegxr_HDR image/sys/*.h image/decode/*.h image/encode/*.h)

add_library(jpegxr_obj OBJECT ${jpegxr_SRC} ${jpegxr_HDR})

add_library(jpegxr $<TARGET_OBJECTS:jpegxr_obj>)
set_target_properties(jpegxr PROPERTIES VERSION ${JXRLIB_LIB_VERSION} SOVERSION ${JXRLIB_SO_VERSION})

# JXR-GLUE Library
file(GLOB jxrglue_SRC jxrgluelib/*.c jxrtestlib/*.c)
file(GLOB jxrglue_HDR jxrgluelib/*.h jxrtestlib/*.h)

add_library(jxr_obj OBJECT ${jxrglue_SRC} ${jxrglue_HDR})
add_library(jxrglue $<TARGET_OBJECTS:jxr_obj>)
set_target_properties(jxrglue PROPERTIES
  VERSION ${JXRLIB_LIB_VERSION}
  SOVERSION ${JXRLIB_SO_VERSION})
target_link_libraries(jxrglue PRIVATE jpegxr m)
set(jpegxr_targets jpegxr jxrglue)

if(BUILD_SHARED_LIBS AND BUILD_STATIC_LIBS)
  add_library(jpegxr_static STATIC $<TARGET_OBJECTS:jpegxr_obj>)
  set_target_properties(jpegxr_static PROPERTIES
    VERSION ${JXRLIB_LIB_VERSION}
    SOVERSION ${JXRLIB_SO_VERSION}
    OUTPUT_NAME jpegxr
    RUNTIME_OUTPUT_NAME jpegxr
    ARCHIVE_OUTPUT_NAME jpegxr)

  add_library(jxrglue_static STATIC $<TARGET_OBJECTS:jxr_obj>)
  set_target_properties(jxrglue_static PROPERTIES
    VERSION ${JXRLIB_LIB_VERSION}
    SOVERSION ${JXRLIB_SO_VERSION}
    OUTPUT_NAME jxrglue
    RUNTIME_OUTPUT_NAME jxrglue
    ARCHIVE_OUTPUT_NAME jxrglue)
  target_link_libraries(jxrglue_static jpegxr_static m)
  list(APPEND jpegxr_targets jpegxr_static jxrglue_static)
endif()

install(TARGETS ${jpegxr_targets}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib${LIB_SUFFIX}
  ARCHIVE DESTINATION lib${LIB_SUFFIX}
)

# JxrEncApp Executable
add_executable(JxrEncApp jxrencoderdecoder/JxrEncApp.c)
target_link_libraries(JxrEncApp jxrglue)
install(TARGETS JxrEncApp RUNTIME DESTINATION bin)

# JxrDecApp Executable
add_executable(JxrDecApp jxrencoderdecoder/JxrDecApp.c)
target_link_libraries(JxrDecApp jxrglue)
install(TARGETS JxrDecApp RUNTIME DESTINATION bin)

# Headers
install(FILES jxrgluelib/JXRGlue.h jxrgluelib/JXRMeta.h jxrtestlib/JXRTest.h image/sys/windowsmediaphoto.h
  DESTINATION include/jxrlib
)
install(DIRECTORY common/include/ DESTINATION include/jxrlib
  FILES_MATCHING PATTERN "*.h"
)
XB_CREATE_CMAKELISTS

# Filelist
# --------
# include/jxrlib/JXRMeta.h
# include/jxrlib/JXRGlue.h
# include/jxrlib/wmspecstrings_undef.h
# include/jxrlib/JXRTest.h
# include/jxrlib/wmspecstring.h
# include/jxrlib/wmspecstrings_strict.h
# include/jxrlib/windowsmediaphoto.h
# include/jxrlib/guiddef.h
# include/jxrlib/wmspecstrings_adt.h
# include/jxrlib/wmsal.h
# lib/pkgconfig/libjxr.pc
# lib/libjpegxr.a
# lib/libjpegxr.so
# lib/libjxrglue.a
# lib/libjxrglue.so
# bin/JxrEncApp
# bin/JxrDecApp
