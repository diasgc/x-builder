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

pc_llib='-ljpegxr -jxrglue'

lst_inc='libjxr/glue/JXRMeta.h libjxr/glue/JXRGlue.h \
		 libjxr/image/perfTimer.h libjxr/image/strcodec.h \
		 libjxr/image/ansi.h libjxr/image/xplatform_image.h \
		 libjxr/image/x86/x86.h libjxr/image/decode.h \
		 libjxr/image/common.h libjxr/image/strTransform.h \
		 libjxr/image/windowsmediaphoto.h libjxr/image/encode.h \
		 libjxr/common/wmspecstrings_undef.h libjxr/common/wmspecstring.h \
		 libjxr/common/wmspecstrings_strict.h libjxr/common/guiddef.h \
		 libjxr/common/wmspecstrings_adt.h libjxr/common/wmsal.h libjxr/test/JXRTest.h'
lst_lib='libjpegxr libjxrglue'
lst_bin='JxrEncApp JxrDecApp'

. xbuilder.sh

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

add_library(jpegxr SHARED $<TARGET_OBJECTS:jpegxr_obj>)
set_target_properties(jpegxr PROPERTIES VERSION ${JXRLIB_LIB_VERSION} SOVERSION ${JXRLIB_SO_VERSION})

add_library(jpegxr_static STATIC $<TARGET_OBJECTS:jpegxr_obj>)
set_target_properties(jpegxr_static PROPERTIES VERSION ${JXRLIB_LIB_VERSION} SOVERSION ${JXRLIB_SO_VERSION} OUTPUT_NAME jpegxr RUNTIME_OUTPUT_NAME jpegxr ARCHIVE_OUTPUT_NAME jpegxr)

install(TARGETS jpegxr
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib${LIB_SUFFIX}
  ARCHIVE DESTINATION lib${LIB_SUFFIX}
)

install(TARGETS jpegxr_static
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib${LIB_SUFFIX}
  ARCHIVE DESTINATION lib${LIB_SUFFIX}
)


# JXR-GLUE Library
file(GLOB jxrglue_SRC jxrgluelib/*.c jxrtestlib/*.c)
file(GLOB jxrglue_HDR jxrgluelib/*.h jxrtestlib/*.h)

add_library(jxr_obj OBJECT ${jxrglue_SRC} ${jxrglue_HDR})

add_library(jxrglue SHARED $<TARGET_OBJECTS:jxr_obj>)
set_target_properties(jxrglue PROPERTIES VERSION ${JXRLIB_LIB_VERSION} SOVERSION ${JXRLIB_SO_VERSION})
target_link_libraries(jxrglue PRIVATE jpegxr m)

add_library(jxrglue_static STATIC $<TARGET_OBJECTS:jxr_obj>)
set_target_properties(jxrglue_static PROPERTIES VERSION ${JXRLIB_LIB_VERSION} SOVERSION ${JXRLIB_SO_VERSION} OUTPUT_NAME jxrglue RUNTIME_OUTPUT_NAME jxrglue ARCHIVE_OUTPUT_NAME jxrglue)
target_link_libraries(jxrglue_static jpegxr_static m)

install(TARGETS jxrglue
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib${LIB_SUFFIX}
  ARCHIVE DESTINATION lib${LIB_SUFFIX}
)

install(TARGETS jxrglue_static
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
