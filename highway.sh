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

lst_inc='hwy/nanobenchmark.h
	hwy/detect_targets.h
	hwy/detect_compiler_arch.h
	hwy/tests/test_util-inl.h
	hwy/tests/hwy_gtest.h
	hwy/tests/test_util.h
	hwy/contrib/sort/sort-inl.h
	hwy/contrib/image/image.h
	hwy/contrib/math/math-inl.h
	hwy/contrib/dot/dot-inl.h
	hwy/highway.h
	hwy/targets.h
	hwy/base.h
	hwy/aligned_allocator.h
	hwy/ops/x86_512-inl.h
	hwy/ops/arm_sve-inl.h
	hwy/ops/generic_ops-inl.h
	hwy/ops/arm_neon-inl.h
	hwy/ops/shared-inl.h
	hwy/ops/x86_128-inl.h
	hwy/ops/wasm_128-inl.h
	hwy/ops/x86_256-inl.h
	hwy/ops/set_macros-inl.h
	hwy/ops/scalar-inl.h
	hwy/cache_control.h
	hwy/foreach_target.h'
lst_lib='libhwy_test libhwy libhwy_contrib'
lst_bin=''

. xbuilder.sh

start

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
