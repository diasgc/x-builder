#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++ +++ +++ +++ clang
# GNU +++ +++  .   .  gcc
# WIN +++ +++  .   .  clang/gcc

lib='giflib'
apt='libgif-dev'
dsc='Library for manipulating GIF files'
lic='other'
src='https://git.code.sf.net/p/giflib/code'
sty='git'
cfg='cmake'
pc_llib='-lgif'
eta='18'
lst_inc='gif_lib.h'
lst_lib='libgiflib'
lst_bin='giftext gifsponge giffilter giffix gifecho \
         gifbg gifhisto gifwedge giftool gifclrmp \
         gif2rgb gifcolor gifbuild gifinto'
dll='libgiflib-7'
cbk="BUILD_UTILITIES"

. xbuilder.sh

start

<<'XB_CREATE_CMAKELISTS'
cmake_minimum_required(VERSION 2.8.12)

project(giflib C)

option(BUILD_STATIC_LIBS "Build static libs" ON)
option(BUILD_UTILITIES "Build utilities" OFF)
option(INSTALL_MAN "Install man" OFF)
option(INSTALL_DOCS "Install docs" OFF)

execute_process(COMMAND ./getversion
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

set(LIBMAJOR 7)
set(LIBMINOR 1)
set(LIBPOINT 0)
set(LIBVER "${LIBMAJOR}.${LIBMINOR}.${LIBPOINT}")

set(giflib_SRC dgif_lib.c egif_lib.c getarg.c
    gifalloc.c gif_err.c gif_font.c gif_hash.c
    openbsd-reallocarray.c qprintf.c quantize.c
)

set(giflib_INSTALLABLE gif2rgb gifbuild gifecho
    giffilter giffix gifinto giftext giftool
    gifsponge gifclrmp
)

set(giflib_UTILS ${giflib_INSTALLABLE}
    gifbg gifcolor gifhisto gifwedge
)

set(giflib_DOCS README NEWS TODO COPYING
    getversion ChangeLog history.adoc
    control doc/*.xml doc/*.txt
    doc/index.html.in doc/00README
)

if(INSTALL_MAN)
  file(GLOB giflib_MAN doc/*.1)
endif()

if(BUILD_SHARED_LIBS)
  add_library(giflib SHARED ${giflib_SRC})
  target_link_libraries(giflib m)
  set_target_properties(giflib PROPERTIES VERSION ${LIBVER} SOVERSION ${LIBMAJOR})
  if(WIN32)
    set_target_properties(giflib PROPERTIES SUFFIX "-${LIBMAJOR}${CMAKE_SHARED_LIBRARY_SUFFIX}")
  endif(WIN32)
endif()

if(BUILD_STATIC_LIBS)
  add_library(giflib_static STATIC ${giflib_SRC})
  set_target_properties(giflib_static PROPERTIES OUTPUT_NAME giflib)
endif()

if(BUILD_UTILITIES)
  foreach(UTILITY ${giflib_UTILS})
    add_executable(${UTILITY} ${UTILITY}.c)
    target_link_libraries(${UTILITY} giflib)
  endforeach()
endif()

if(BUILD_SHARED_LIBS)
  install(TARGETS giflib
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib${LIB_SUFFIX}
    LIBRARY DESTINATION lib${LIB_SUFFIX})
endif()

if(BUILD_STATIC_LIBS)
  install(TARGETS giflib_static ARCHIVE DESTINATION lib${LIB_SUFFIX})
endif()

if(BUILD_UTILITIES)
  foreach(UTILITY ${giflib_UTILS})
    install(TARGETS ${UTILITY} DESTINATION bin)
  endforeach()
endif()

install(FILES gif_lib.h DESTINATION include)

if(INSTALL_MAN)
  install(FILES ${giflib_MAN} DESTINATION ${CMAKE_INSTALL_PREFIX}/man/man1)
endif()

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/doc
    DESTINATION ${CMAKE_INSTALL_PREFIX}/share/gif
    FILES_MATCHING PATTERN "*ml")
XB_CREATE_CMAKELISTS

# Filelist
# --------
# include/gif_lib.h
# lib/libgiflib.a
# lib/pkgconfig/giflib.pc
# lib/libgiflib.so
# bin/giftext
# bin/gifsponge
# bin/giffilter
# bin/giffix
# bin/gifecho
# bin/gifbg
# bin/gifhisto
# bin/gifwedge
# bin/giftool
# bin/gifclrmp
# bin/gif2rgb
# bin/gifcolor
# bin/gifbuild
# bin/gifinto
