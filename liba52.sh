#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='liba52'
vrs='0.7.4'
apt="liba52-${vrs}-dev"
dsc='liba52 is a free library for decoding ATSC A/52 streams'
lic='GPL'
src="https://liba52.sourceforge.io/files/a52dec-${vrs}.tar.gz"
cfg='cmake'
eta='10'

pc_llib='-la52'

lst_inc='a52_internal.h bitstream.h tables.h'
lst_lib='liba52'
lst_bin=''
lst_oth=''

. xbuilder.sh

start

# automake too old cannot recognize arm machines
<<'XB_CREATE_CMAKELISTS'
cmake_minimum_required(VERSION 3.10)

project(liba52 C)
option(BUILD_STATIC_LIBS "Build static libs" ON)
#cannot build executables
#option(BUILD_EXECUTABLES "Build executables" OFF)
#option(INSTALL_MAN "Install man" OFF)
#option(INSTALL_DOCS "Install docs" OFF)

add_compile_options("-Wno-shift-negative-value")

include_directories(${CMAKE_SOURCE_DIR} include liba52 src libao vc++)

file(GLOB src_libao libao/*.c)
file(GLOB src_liba52 liba52/*.c)
file(GLOB hdr_liba52 liba52/*.h)
file(GLOB src_liba52dec src/*.c)
file(GLOB hdr_liba52dec src/*.h)

# add_library(libao STATIC ${src_libao})

if(BUILD_SHARED_LIBS)
  add_library(a52 SHARED ${src_liba52})
endif()

if(BUILD_STATIC_LIBS)
  add_library(a52_static STATIC ${src_liba52})
  set_target_properties(a52_static PROPERTIES OUTPUT_NAME a52)
endif()

#if(BUILD_EXECUTABLES)
#    add_executable(a52dec ${src_liba52dec})
#    target_link_libraries(a52dec a52)
#endif()

if(BUILD_SHARED_LIBS)
  install(TARGETS a52
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib${LIB_SUFFIX}
    LIBRARY DESTINATION lib${LIB_SUFFIX})
endif()

if(BUILD_STATIC_LIBS)
  install(TARGETS a52_static ARCHIVE DESTINATION lib${LIB_SUFFIX})
endif()

install(FILES libdeflate.h DESTINATION include)

#if(BUILD_EXECUTABLES)
#  install(TARGETS a52dec RUNTIME DESTINATION bin)
#endif()

if(INSTALL_MAN)
	install(FILES pbmtools/jbgtopbm.1 pbmtools/pbmtojbg.1 DESTINATION \${CMAKE_INSTALL_PREFIX}/share/man/man1)
	install(FILES pbmtools/pbm.5 pbmtools/pgm.5 DESTINATION \${CMAKE_INSTALL_PREFIX}/share/man/man5)
endif()

install(FILES COPYING README.md TODO DESTINATION \${CMAKE_INSTALL_PREFIX}/share/docs/libjbig)
XB_CREATE_CMAKELISTS

# Filelist
# --------
# include/a52_internal.h
# include/bitstream.h
# include/tables.h
# lib/liba52.a
# lib/liba52.so
