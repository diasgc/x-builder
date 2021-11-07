#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++  ... ... ...
# linux-gnu   ++  ... ... ...
# mingw-llvm  ... ... ... ...

lib='freeimage'
apt="${lib}-dev"
dsc='Open Source library to support popular graphics image formats like PNG, BMP, JPEG, TIFF'
lic='Other'
src='https://svn.code.sf.net/p/freeimage/svn/'
cfg='cmake'
eta='440'
pc_llib="-lfreeimage"

lst_inc='FreeImage.h FreeImagePlus.h'
lst_lib='libFreeImage'
lst_bin=''

. xbuilder.sh

source_config(){
    mv $SRCDIR/FreeImage/trunk $SRCDIR/..
    rm -rf $SRCDIR
    mv $SOURCES/trunk $SRCDIR
}

source_patch(){
    cd ${SRCDIR}
    cp Source/FreeImage.h Dist
    s0=$(cat Makefile.srcs | sed -e 's| Source| ./Source|g; s| \./|\n\t|g')
    #s1=$(cat ${SRCDIR}/fipMakefile.srcs | sed -e 's| Source| ./Sources|g; s| \./|\n\t|g')
    local srcs=$(echo "$s0" | sed -n '/SRCS/,/INCLS/p' | sed '1d; $d')
    #local sfip=$(echo "$s1" | sed -n '/SRCS/,/INCLUDE = /p' | sed '1d; $d')
    local hdrs=$(echo "$s0" | sed -n '/INCLS/,/\n\n/p' | sed '1d; $d')
    local incl=$(echo "$s0" | sed -n '/INCLUDE = /,/$/p' | sed ' s/ -I/\n\t/g' | sed '1,2d')
    echo "$(awk -v r="$srcs" '{gsub(/@sourcelist@/,r)}1' CMakeLists.txt)" > CMakeLists.txt
    echo "$(awk -v r="$hdrs" '{gsub(/@headerlist@/,r)}1' CMakeLists.txt)" > CMakeLists.txt
    echo "$(awk -v r="$incl" '{gsub(/@incldir_list@/,r)}1' CMakeLists.txt)" > CMakeLists.txt
}

start

<<'XB_CREATE_CMAKELISTS'
cmake_minimum_required(VERSION 3.11)

project(FreeImage)

set(VERLIBNAME 3.19.0)

set(SRCS @sourcelist@
    )

set(HDRS @headerlist@
    )

include_directories(${CMAKE_SOURCE_DIR}
    @incldir_list@
    )

set (ALL_SRC ${SRCS} ${HDRS})

if(UNIX)
	add_definitions(-O3 -fPIC -fexceptions -fvisibility=hidden -D__ANSI__)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 -DOPJ_STATIC -DNO_LCMS -DDISABLE_PERF_MEASUREMENT")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -lstdc++ -lm")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else()
	# todo mingw32
	add_definitions(-O3 -fexceptions -DNDEBUG)
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DDISABLE_PERF_MEASUREMENT -D__ANSI__ -DOPJ_STATIC")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -Wno-ctor-dtor-privacy")
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -s -shared -static -lws2_32")
endif()

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^a")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DPNG_ARM_NEON_OPT=OFF")
endif()

add_library(freeimage STATIC ${ALL_SRC})
set(TARGETS freeimage)

if(BUILD_SHARED_LIBS)
    add_library(freeimage_shared SHARED ${ALL_SRC})
    set_target_properties(freeimage_shared PROPERTIES OUTPUT_NAME freeimage)
    set(TARGETS freeimage freeimage_shared)
endif()

install(TARGETS ${TARGETS}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib${LIB_SUFFIX}
  ARCHIVE DESTINATION lib${LIB_SUFFIX}
)

install(FILES Source/FreeImage.h DESTINATION include)
install(FILES Wrapper/FreeImagePlus/FreeImagePlus.h DESTINATION include)
install(FILES licence-*.txt DESTINATION share/docs/FreeImage)
XB_CREATE_CMAKELISTS

# Filelist
# --------
# include/FreeImage.h
# include/FreeImagePlus.h
# lib/pkgconfig/freeimage.pc
# lib/libFreeImage.a
# lib/libFreeImage.so
