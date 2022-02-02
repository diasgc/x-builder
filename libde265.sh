#!/bin/bash
# cpu  av8 av7 x86 x64  cc
# NDK  P+. P+.  .   .   clang
# GNU  P+.  .   .   .   gcc
# WIN  P+.  .   .  P++  clang

lib='libde265'
apt='libde265-dev'
dsc='Open h.265 video codec implementation.'
lic='LGPL-3.0'
src='https://github.com/strukturag/libde265.git'
cfg='cmake'
eta='140'

lst_inc='libde265/*.h'
lst_lib='liblibde265'
lst_bin='enc265 hdrcopy dec265'
lst_lic='COPYING AUTHORS'
lst_pc='libde265.pc'

dev_bra='main'
dev_vrs=''
stb_bra=''
stb_vrs=''

cmake_static='BUILD_STATIC_LIBS'
cmake_cfg='-DENABLE_SDL=OFF'

. xbuilder.sh

$host_arm && cmake_cfg+=' -DDISABLE_SSE=ON' || cmake_cfg+=' -DDISABLE_SSE=OFF'
case $cfg in
  #cmake) pc_llib='-lde265' pc_libsprivate='-lpthread -lstdc++';;
  ag)    $host_arm && ac_cfg+=" --disable-sse --disable-arm"
         $host_mingw && CSH=${CSH/"--disable-shared "} #see similar https://github.com/opencv/opencv/pull/9052
         ;;
esac

WFLAGS='-Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function -Wno-uninitialized'

source_config(){
       set -x
       ./autogen.sh
       [ -f "libde265/de265-version.h" ] || ln extra/libde265/de265-version.h libde265/de265-version.h
       set +x
}


start
<<'libde265/CMakeLists.txt'
include(CMakePackageConfigHelpers)

set (libde265_sources 
  alloc_pool.cc
  bitstream.cc
  cabac.cc
  configparam.cc
  contextmodel.cc
  de265.cc
  deblock.cc
  decctx.cc
  dpb.cc
  en265.cc
  fallback-dct.cc
  fallback-motion.cc 
  fallback.cc
  image-io.cc
  image.cc
  intrapred.cc
  md5.cc
  motion.cc
  nal-parser.cc
  nal.cc
  pps.cc
  quality.cc
  refpic.cc
  sao.cc
  scan.cc
  sei.cc
  slice.cc
  sps.cc
  threads.cc
  transform.cc
  util.cc
  visualize.cc
  vps.cc
  vui.cc
)

set (libde265_headers
  acceleration.h
  alloc_pool.h
  bitstream.h
  cabac.h
  configparam.h
  de265-version.h
  contextmodel.h
  de265.h
  deblock.h
  decctx.h
  dpb.h
  en265.h
  fallback-dct.h
  fallback-motion.h
  fallback.h
  image-io.h
  image.h
  intrapred.h
  md5.h
  motion.h
  nal-parser.h
  nal.h
  pps.h
  quality.h
  refpic.h
  sao.h
  scan.h
  sei.h
  slice.h
  sps.h
  threads.h
  transform.h
  util.h
  visualize.h
  vps.h
  vui.h
)

if(MSVC OR MINGW)
  set (libde265_sources
    ${libde265_sources}
    ../extra/win32cond.c
    ../extra/win32cond.h
  )
endif()

add_definitions(-DLIBDE265_EXPORTS)
add_compile_options(-Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function -Wno-uninitialized)
add_subdirectory (encoder)

if(NOT DISABLE_SSE)
  if (MSVC)
    set(SUPPORTS_SSE2 1)
    set(SUPPORTS_SSSE3 1)
    set(SUPPORTS_SSE4_1 1)
  else (MSVC)
    check_c_compiler_flag(-msse2 SUPPORTS_SSE2)
    check_c_compiler_flag(-mssse3 SUPPORTS_SSSE3)
    check_c_compiler_flag(-msse4.1 SUPPORTS_SSE4_1)
  endif (MSVC)

  if(SUPPORTS_SSE4_1)
    add_definitions(-DHAVE_SSE4_1)
  endif()
  if(SUPPORTS_SSE4_1 OR (SUPPORTS_SSE2 AND SUPPORTS_SSSE3))
    add_subdirectory (x86)
  endif()
endif()

add_library(${PROJECT_NAME} ${libde265_sources} ${ENCODER_OBJECTS} ${X86_OBJECTS})
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
set(libde265_targets ${PROJECT_NAME})
if(BUILD_SHARED_LIBS AND BUILD_STATIC_LIBS)
  add_library(${PROJECT_NAME}-static STATIC ${libde265_sources} ${ENCODER_OBJECTS} ${X86_OBJECTS})
  target_link_libraries(${PROJECT_NAME}-static PRIVATE Threads::Threads)
  set_target_properties(${PROJECT_NAME}-static PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
  list(APPEND libde265_targets ${PROJECT_NAME}-static)
endif()
write_basic_package_version_file(${PROJECT_NAME}ConfigVersion.cmake COMPATIBILITY ExactVersion)

install(TARGETS ${libde265_targets} EXPORT ${PROJECT_NAME}Config
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(FILES ${libde265_headers} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/de265-version.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})

install(EXPORT ${PROJECT_NAME}Config DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake DESTINATION
    "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
libde265/CMakeLists.txt

# Filelist
# --------
# include/libde265/motion.h
# include/libde265/fallback-dct.h
# include/libde265/cabac.h
# include/libde265/deblock.h
# include/libde265/pps.h
# include/libde265/en265.h
# include/libde265/fallback-motion.h
# include/libde265/sei.h
# include/libde265/fallback.h
# include/libde265/image-io.h
# include/libde265/scan.h
# include/libde265/threads.h
# include/libde265/contextmodel.h
# include/libde265/transform.h
# include/libde265/bitstream.h
# include/libde265/sps.h
# include/libde265/vps.h
# include/libde265/slice.h
# include/libde265/md5.h
# include/libde265/alloc_pool.h
# include/libde265/image.h
# include/libde265/sao.h
# include/libde265/vui.h
# include/libde265/decctx.h
# include/libde265/refpic.h
# include/libde265/de265.h
# include/libde265/configparam.h
# include/libde265/quality.h
# include/libde265/de265-version.h
# include/libde265/nal.h
# include/libde265/nal-parser.h
# include/libde265/intrapred.h
# include/libde265/visualize.h
# include/libde265/acceleration.h
# include/libde265/dpb.h
# include/libde265/util.h
# lib/cmake/libde265/libde265ConfigVersion.cmake
# lib/cmake/libde265/libde265Config-release.cmake
# lib/cmake/libde265/libde265Config.cmake
# lib/liblibde265.so
# lib/liblibde265.a
# share/doc/libde265/AUTHORS
# share/doc/libde265/COPYING
# bin/enc265
# bin/hdrcopy
# bin/dec265
