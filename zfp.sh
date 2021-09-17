#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+  .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='zfp'
dsc='Compressed numerical arrays that support high-speed random access'
lic='BSD-3c'
src='https://github.com/LLNL/zfp.git'
sty='git'
cfg='cm'
eta='190'
cmake_path='lib/cmake/zfp'

. xbuilder.sh

CFG="-DBUILD_TESTING=OFF -DBUILD_GMOCK=OFF"
pkgconfig_url='http://oldhome.schmorp.de/marc/liblzf.html'
pkgconfig_llib='-llzf'

start


# CMAKE OPTIONS
# -DBUILD_ALL                        OFF
# -DBUILD_CFP                        OFF
# -DBUILD_EXAMPLES                   OFF
# -DBUILD_GMOCK                      ON
# -DBUILD_SHARED_LIBS                OFF
# -DBUILD_TESTING                    ON
# -DBUILD_UTILITIES                  ON
# -DBUILD_ZFORP                      OFF
# -DBUILD_ZFPY                       OFF
# -DINSTALL_GMOCK                    OFF
# -DINSTALL_GTEST                    OFF
# -DPPM_CHROMA                       2
# -DZFP_BIT_STREAM_WORD_SIZE         64
# -DZFP_BUILD_TESTING_LARGE          OFF
# -DZFP_BUILD_TESTING_SMALL          ON
# -DZFP_ENABLE_PIC                   ON
# -DZFP_ROUNDING_MODE                ZFP_ROUND_NEVER
# -DZFP_WITH_CUDA                    OFF
# -DZFP_WITH_DAZ                     OFF
# -DZFP_WITH_OPENMP                  ON
# -DZFP_WITH_TIGHT_ERROR             OFF

# Filelist
# --------

# include/zfpcarray3.h
# include/zfparray.h
# include/zfpcarray2.h
# include/zfparray2.h
# include/zfpcarray1.h
# include/bitstream.h
# include/zfparray1.h
# include/zfp/exception.h
# include/zfp/pointer2.h
# include/zfp/view2.h
# include/zfp/handle2.h
# include/zfp/view3.h
# include/zfp/cache.h
# include/zfp/store3.h
# include/zfp/iterator1.h
# include/zfp/cache4.h
# include/zfp/iterator2.h
# include/zfp/memory.h
# include/zfp/cache2.h
# include/zfp/view4.h
# include/zfp/zfpheader.h
# include/zfp/types.h
# include/zfp/store2.h
# include/zfp/traits.h
# include/zfp/handle4.h
# include/zfp/reference1.h
# include/zfp/store1.h
# include/zfp/store.h
# include/zfp/pointer4.h
# include/zfp/iterator4.h
# include/zfp/handle3.h
# include/zfp/reference4.h
# include/zfp/cache1.h
# include/zfp/version.h
# include/zfp/pointer1.h
# include/zfp/cache3.h
# include/zfp/pointer3.h
# include/zfp/reference2.h
# include/zfp/view1.h
# include/zfp/reference3.h
# include/zfp/store4.h
# include/zfp/header.h
# include/zfp/macros.h
# include/zfp/iterator3.h
# include/zfp/handle1.h
# include/zfp/system.h
# include/zfpcpp.h
# include/zfpcarray4.h
# include/zfpindex.h
# include/zfparray3.h
# include/zfpcodec.h
# include/zfparray4.h
# include/zfpfactory.h
# include/zfp.h
# include/ieeecodec.h
# lib/cmake/zfp/zfp-targets-release.cmake
# lib/cmake/zfp/zfp-targets.cmake
# lib/cmake/zfp/zfp-config-version.cmake
# lib/cmake/zfp/zfp-config.cmake
# lib/libzfp.so
