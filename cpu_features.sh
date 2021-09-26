#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='cpu_features'
dsc='A cross platform C99 library to get cpu features at runtime'
lic='Apache-2.0'
src='https://github.com/google/cpu_features.git'
sty='git'
cfg='cm'
pkg='cpu_features'
pc_llib='-lcpufeatures'
CFG='-DBUILD_PIC=ON'

. xbuilder.sh

start

# Filelist
# --------
# include/ndk_compat/cpu-features.h
# include/cpu_features/cpu_features_cache_info.h
# include/cpu_features/cpuinfo_arm.h
# include/cpu_features/cpu_features_macros.h
# lib/libcpu_features.a
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatTargets.cmake
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatConfig.cmake
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatTargets-release.cmake
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatConfigVersion.cmake
# lib/cmake/CpuFeatures/CpuFeaturesConfigVersion.cmake
# lib/cmake/CpuFeatures/CpuFeaturesTargets.cmake
# lib/cmake/CpuFeatures/CpuFeaturesConfig.cmake
# lib/cmake/CpuFeatures/CpuFeaturesTargets-release.cmake
# lib/libndk_compat.a
# bin/list_cpu_features
