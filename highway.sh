#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +   +   ... ... CLANG
# GNU +   +   ... +   GCC
# WIN +   +   ... +   CLANG/GCC

lib='highway'
pkg='libhwy'
dsc='Performance-portable, length-agnostic SIMD with runtime dispatch'
lic='Apache2.0'
src='https://github.com/google/highway.git'
cfg='cmake'
eta='10'
lcv='0.14.2'

CFG="-DBUILD_GMOCK=OFF -DBUILD_TESTING=OFF -DHWY_EXAMPLES_TESTS_INSTALL=ON"

lst_inc='hwy/*.h hwy/tests/*.h hwy/contrib/*.h hwy/*.h hwy/ops/*.h'
lst_lib='libhwy.* libhwy_test.* libhwy_contrib.*'
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc='libhwy.pc libhwy-test.pc libhwy-contrib.pc'

. xbuilder.sh

start

<<'TODO_PATCH_CMAKE'
set(hwy_targets hwy hwy_contrib hwy_test)
if(BUILD_STATIC_LIBS AND BUILD_SHARED_LIBS)
  add_library(hwy_static STATIC ${HWY_SOURCES})
  target_compile_definitions(hwy_static PUBLIC "${DLLEXPORT_TO_DEFINE}")
  target_compile_options(hwy_static PRIVATE ${HWY_FLAGS})
  set_property(TARGET (hwy_static PROPERTY POSITION_INDEPENDENT_CODE ON)
  set_target_properties(hwy_static PROPERTIES VERSION ${LIBRARY_VERSION} SOVERSION ${LIBRARY_SOVERSION})
  set_target_properties(hwy_static PROPERTIES OUTPUT_NAME hwy)
  target_include_directories(hwy_static PUBLIC ${CMAKE_CURRENT_LIST_DIR})
  target_compile_features(hwy_static PUBLIC cxx_std_11)
  set_target_properties(hwy_static PROPERTIES
  LINK_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/hwy/hwy.version)
  if(UNIX)
    set_property(TARGET (hwy_static APPEND_STRING PROPERTY
      LINK_FLAGS " -Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/hwy/hwy.version")
  endif()
  add_library(hwy_contrib_static STATIC ${HWY_CONTRIB_SOURCES})
  target_link_libraries(hwy_contrib_static hwy_static)
  target_compile_options(hwy_contrib_static PRIVATE ${HWY_FLAGS})
  set_target_properties(hwy_static PROPERTIES OUTPUT_NAME hwy_contrib)
  set_property(TARGET (hwy_contrib_static PROPERTY POSITION_INDEPENDENT_CODE ON)
  set_target_properties(hwy_contrib_static PROPERTIES VERSION ${LIBRARY_VERSION} SOVERSION ${LIBRARY_SOVERSION})
  target_include_directories(hwy_contrib_static PUBLIC ${CMAKE_CURRENT_LIST_DIR})
  target_compile_features(hwy_contrib_static PUBLIC cxx_std_11)

  add_library(hwy_test_static STATIC ${HWY_TEST_SOURCES})
  set_target_properties(hwy_test_static PROPERTIES OUTPUT_NAME hwy_test)
  target_link_librariesh(wy_test_static hwy_static)
  target_compile_options(hwy_test_static PRIVATE ${HWY_FLAGS})
  set_property(TARGET hwy_test_static PROPERTY POSITION_INDEPENDENT_CODE ON)
  set_target_properties(hwy_test_static PROPERTIES VERSION ${LIBRARY_VERSION} SOVERSION ${LIBRARY_SOVERSION})
  target_include_directories(hwy_test_static PUBLIC ${CMAKE_CURRENT_LIST_DIR})
  target_compile_features(hwy_test_static PUBLIC cxx_std_11)
  list(APPEND hwy_targets hwy_static hwy_contrib_static hwy_test_static)
endif()

install(TARGETS ${hwy_targets}
  DESTINATION "${CMAKE_INSTALL_LIBDIR}")
TODO_PATCH_CMAKE

# Filelist
# --------
# include/hwy/nanobenchmark.h
# include/hwy/detect_targets.h
# include/hwy/detect_compiler_arch.h
# include/hwy/tests/test_util-inl.h
# include/hwy/tests/hwy_gtest.h
# include/hwy/tests/test_util.h
# include/hwy/contrib/sort/sort-inl.h
# include/hwy/contrib/image/image.h
# include/hwy/contrib/math/math-inl.h
# include/hwy/contrib/dot/dot-inl.h
# include/hwy/highway.h
# include/hwy/targets.h
# include/hwy/base.h
# include/hwy/aligned_allocator.h
# include/hwy/ops/x86_512-inl.h
# include/hwy/ops/arm_sve-inl.h
# include/hwy/ops/generic_ops-inl.h
# include/hwy/ops/arm_neon-inl.h
# include/hwy/ops/shared-inl.h
# include/hwy/ops/x86_128-inl.h
# include/hwy/ops/wasm_128-inl.h
# include/hwy/ops/x86_256-inl.h
# include/hwy/ops/set_macros-inl.h
# include/hwy/ops/scalar-inl.h
# include/hwy/cache_control.h
# include/hwy/foreach_target.h
# lib/pkgconfig/libhwy-test.pc
# lib/pkgconfig/libhwy.pc
# lib/pkgconfig/libhwy-contrib.pc
# lib/libhwy_test.a
# lib/libhwy.a
# lib/libhwy_contrib.a
