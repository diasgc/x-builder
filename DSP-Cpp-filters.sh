#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='DSP-Cpp-filters'
dsc='DSP C++ audio filters'
lic='MIT'
src='https://github.com/dimtass/DSP-Cpp-filters.git'
cfg='cmake'
eta='0'

mki=''
cstk=''
cshk=''
cbk=''

lst_inc=''
lst_lib=''
lst_bin=''
lst_lic='COPYING.MIT'
lst_pc=''

eta='20'

. xbuilder.sh

start

# Filelist
# --------
# cmake_install.cmake
# CMakeCache.txt
# tests/cmake_install.cmake
# tests/so_bsf_test
# tests/so_hpf_test
# tests/so_bpf_test
# tests/so_butterworth_bpf_test
# tests/so_parametric_cq_boost_test
# tests/so_butterworth_bsf_test
# tests/so_parametric_cq_cut_test
# tests/so_lpf_test
# tests/so_apf_test
# tests/fo_apf_test
# tests/so_linkwitz_riley_hpf_test
# tests/fo_shelving_low_test
# tests/so_parametric_ncq_test
# tests/so_butterworth_lpf_test
# tests/fo_hpf_test
# tests/CTestTestfile.cmake
# tests/Makefile
# tests/fo_shelving_high_test
# tests/fo_lpf_test
# tests/so_butterworth_hpf_test
# tests/so_linkwitz_riley_lpf_test
# tests/CMakeFiles/so_butterworth_bsf_test.dir/progress.make
# tests/CMakeFiles/so_butterworth_bsf_test.dir/depend.make
# tests/CMakeFiles/so_butterworth_bsf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_butterworth_bsf_test.dir/build.make
# tests/CMakeFiles/so_butterworth_bsf_test.dir/so_butterworth_bsf_test.cpp.o
# tests/CMakeFiles/so_butterworth_bsf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_butterworth_bsf_test.dir/flags.make
# tests/CMakeFiles/so_butterworth_bsf_test.dir/so_butterworth_bsf_test.cpp.o.d
# tests/CMakeFiles/so_butterworth_bsf_test.dir/link.txt
# tests/CMakeFiles/so_butterworth_bsf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_butterworth_bsf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_butterworth_bsf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_bpf_test.dir/progress.make
# tests/CMakeFiles/so_bpf_test.dir/depend.make
# tests/CMakeFiles/so_bpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_bpf_test.dir/build.make
# tests/CMakeFiles/so_bpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_bpf_test.dir/flags.make
# tests/CMakeFiles/so_bpf_test.dir/so_bpf_test.cpp.o
# tests/CMakeFiles/so_bpf_test.dir/so_bpf_test.cpp.o.d
# tests/CMakeFiles/so_bpf_test.dir/link.txt
# tests/CMakeFiles/so_bpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_bpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_bpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_lpf_test.dir/progress.make
# tests/CMakeFiles/so_lpf_test.dir/depend.make
# tests/CMakeFiles/so_lpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_lpf_test.dir/build.make
# tests/CMakeFiles/so_lpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_lpf_test.dir/so_lpf_test.cpp.o.d
# tests/CMakeFiles/so_lpf_test.dir/flags.make
# tests/CMakeFiles/so_lpf_test.dir/so_lpf_test.cpp.o
# tests/CMakeFiles/so_lpf_test.dir/link.txt
# tests/CMakeFiles/so_lpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_lpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_lpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_butterworth_lpf_test.dir/progress.make
# tests/CMakeFiles/so_butterworth_lpf_test.dir/depend.make
# tests/CMakeFiles/so_butterworth_lpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_butterworth_lpf_test.dir/build.make
# tests/CMakeFiles/so_butterworth_lpf_test.dir/so_butterworth_lpf_test.cpp.o.d
# tests/CMakeFiles/so_butterworth_lpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_butterworth_lpf_test.dir/flags.make
# tests/CMakeFiles/so_butterworth_lpf_test.dir/link.txt
# tests/CMakeFiles/so_butterworth_lpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_butterworth_lpf_test.dir/so_butterworth_lpf_test.cpp.o
# tests/CMakeFiles/so_butterworth_lpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_butterworth_lpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/fo_apf_test.dir/progress.make
# tests/CMakeFiles/fo_apf_test.dir/depend.make
# tests/CMakeFiles/fo_apf_test.dir/compiler_depend.make
# tests/CMakeFiles/fo_apf_test.dir/build.make
# tests/CMakeFiles/fo_apf_test.dir/compiler_depend.internal
# tests/CMakeFiles/fo_apf_test.dir/flags.make
# tests/CMakeFiles/fo_apf_test.dir/fo_apf_test.cpp.o
# tests/CMakeFiles/fo_apf_test.dir/link.txt
# tests/CMakeFiles/fo_apf_test.dir/compiler_depend.ts
# tests/CMakeFiles/fo_apf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/fo_apf_test.dir/fo_apf_test.cpp.o.d
# tests/CMakeFiles/fo_apf_test.dir/DependInfo.cmake
# tests/CMakeFiles/check.dir/progress.make
# tests/CMakeFiles/check.dir/compiler_depend.make
# tests/CMakeFiles/check.dir/build.make
# tests/CMakeFiles/check.dir/compiler_depend.ts
# tests/CMakeFiles/check.dir/cmake_clean.cmake
# tests/CMakeFiles/check.dir/DependInfo.cmake
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/progress.make
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/depend.make
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/build.make
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/so_linkwitz_riley_lpf_test.cpp.o.d
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/flags.make
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/so_linkwitz_riley_lpf_test.cpp.o
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/link.txt
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_linkwitz_riley_lpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/CMakeDirectoryInformation.cmake
# tests/CMakeFiles/fo_lpf_test.dir/fo_lpf_test.cpp.o.d
# tests/CMakeFiles/fo_lpf_test.dir/progress.make
# tests/CMakeFiles/fo_lpf_test.dir/depend.make
# tests/CMakeFiles/fo_lpf_test.dir/compiler_depend.make
# tests/CMakeFiles/fo_lpf_test.dir/build.make
# tests/CMakeFiles/fo_lpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/fo_lpf_test.dir/flags.make
# tests/CMakeFiles/fo_lpf_test.dir/fo_lpf_test.cpp.o
# tests/CMakeFiles/fo_lpf_test.dir/link.txt
# tests/CMakeFiles/fo_lpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/fo_lpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/fo_lpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/progress.make
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/depend.make
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/compiler_depend.make
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/build.make
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/flags.make
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/link.txt
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/so_parametric_cq_boost_test.cpp.o
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_parametric_cq_boost_test.dir/so_parametric_cq_boost_test.cpp.o.d
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/progress.make
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/depend.make
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/compiler_depend.make
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/build.make
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/so_parametric_cq_cut_test.cpp.o
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/flags.make
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/so_parametric_cq_cut_test.cpp.o.d
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/link.txt
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_parametric_cq_cut_test.dir/DependInfo.cmake
# tests/CMakeFiles/fo_shelving_high_test.dir/progress.make
# tests/CMakeFiles/fo_shelving_high_test.dir/depend.make
# tests/CMakeFiles/fo_shelving_high_test.dir/fo_shelving_high_test.cpp.o.d
# tests/CMakeFiles/fo_shelving_high_test.dir/compiler_depend.make
# tests/CMakeFiles/fo_shelving_high_test.dir/build.make
# tests/CMakeFiles/fo_shelving_high_test.dir/compiler_depend.internal
# tests/CMakeFiles/fo_shelving_high_test.dir/flags.make
# tests/CMakeFiles/fo_shelving_high_test.dir/fo_shelving_high_test.cpp.o
# tests/CMakeFiles/fo_shelving_high_test.dir/link.txt
# tests/CMakeFiles/fo_shelving_high_test.dir/compiler_depend.ts
# tests/CMakeFiles/fo_shelving_high_test.dir/cmake_clean.cmake
# tests/CMakeFiles/fo_shelving_high_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_parametric_ncq_test.dir/progress.make
# tests/CMakeFiles/so_parametric_ncq_test.dir/depend.make
# tests/CMakeFiles/so_parametric_ncq_test.dir/so_parametric_ncq_test.cpp.o.d
# tests/CMakeFiles/so_parametric_ncq_test.dir/so_parametric_ncq_test.cpp.o
# tests/CMakeFiles/so_parametric_ncq_test.dir/compiler_depend.make
# tests/CMakeFiles/so_parametric_ncq_test.dir/build.make
# tests/CMakeFiles/so_parametric_ncq_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_parametric_ncq_test.dir/flags.make
# tests/CMakeFiles/so_parametric_ncq_test.dir/link.txt
# tests/CMakeFiles/so_parametric_ncq_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_parametric_ncq_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_parametric_ncq_test.dir/DependInfo.cmake
# tests/CMakeFiles/fo_hpf_test.dir/progress.make
# tests/CMakeFiles/fo_hpf_test.dir/depend.make
# tests/CMakeFiles/fo_hpf_test.dir/compiler_depend.make
# tests/CMakeFiles/fo_hpf_test.dir/build.make
# tests/CMakeFiles/fo_hpf_test.dir/fo_hpf_test.cpp.o
# tests/CMakeFiles/fo_hpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/fo_hpf_test.dir/flags.make
# tests/CMakeFiles/fo_hpf_test.dir/fo_hpf_test.cpp.o.d
# tests/CMakeFiles/fo_hpf_test.dir/link.txt
# tests/CMakeFiles/fo_hpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/fo_hpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/fo_hpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_butterworth_hpf_test.dir/progress.make
# tests/CMakeFiles/so_butterworth_hpf_test.dir/depend.make
# tests/CMakeFiles/so_butterworth_hpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_butterworth_hpf_test.dir/build.make
# tests/CMakeFiles/so_butterworth_hpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_butterworth_hpf_test.dir/so_butterworth_hpf_test.cpp.o
# tests/CMakeFiles/so_butterworth_hpf_test.dir/flags.make
# tests/CMakeFiles/so_butterworth_hpf_test.dir/so_butterworth_hpf_test.cpp.o.d
# tests/CMakeFiles/so_butterworth_hpf_test.dir/link.txt
# tests/CMakeFiles/so_butterworth_hpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_butterworth_hpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_butterworth_hpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_apf_test.dir/progress.make
# tests/CMakeFiles/so_apf_test.dir/depend.make
# tests/CMakeFiles/so_apf_test.dir/so_apf_test.cpp.o.d
# tests/CMakeFiles/so_apf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_apf_test.dir/so_apf_test.cpp.o
# tests/CMakeFiles/so_apf_test.dir/build.make
# tests/CMakeFiles/so_apf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_apf_test.dir/flags.make
# tests/CMakeFiles/so_apf_test.dir/link.txt
# tests/CMakeFiles/so_apf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_apf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_apf_test.dir/DependInfo.cmake
# tests/CMakeFiles/fo_shelving_low_test.dir/progress.make
# tests/CMakeFiles/fo_shelving_low_test.dir/depend.make
# tests/CMakeFiles/fo_shelving_low_test.dir/compiler_depend.make
# tests/CMakeFiles/fo_shelving_low_test.dir/fo_shelving_low_test.cpp.o
# tests/CMakeFiles/fo_shelving_low_test.dir/fo_shelving_low_test.cpp.o.d
# tests/CMakeFiles/fo_shelving_low_test.dir/build.make
# tests/CMakeFiles/fo_shelving_low_test.dir/compiler_depend.internal
# tests/CMakeFiles/fo_shelving_low_test.dir/flags.make
# tests/CMakeFiles/fo_shelving_low_test.dir/link.txt
# tests/CMakeFiles/fo_shelving_low_test.dir/compiler_depend.ts
# tests/CMakeFiles/fo_shelving_low_test.dir/cmake_clean.cmake
# tests/CMakeFiles/fo_shelving_low_test.dir/DependInfo.cmake
# tests/CMakeFiles/progress.marks
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/progress.make
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/depend.make
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/build.make
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/flags.make
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/so_linkwitz_riley_hpf_test.cpp.o
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/link.txt
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/so_linkwitz_riley_hpf_test.cpp.o.d
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_linkwitz_riley_hpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_bsf_test.dir/progress.make
# tests/CMakeFiles/so_bsf_test.dir/depend.make
# tests/CMakeFiles/so_bsf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_bsf_test.dir/build.make
# tests/CMakeFiles/so_bsf_test.dir/so_bsf_test.cpp.o.d
# tests/CMakeFiles/so_bsf_test.dir/so_bsf_test.cpp.o
# tests/CMakeFiles/so_bsf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_bsf_test.dir/flags.make
# tests/CMakeFiles/so_bsf_test.dir/link.txt
# tests/CMakeFiles/so_bsf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_bsf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_bsf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_butterworth_bpf_test.dir/progress.make
# tests/CMakeFiles/so_butterworth_bpf_test.dir/depend.make
# tests/CMakeFiles/so_butterworth_bpf_test.dir/so_butterworth_bpf_test.cpp.o.d
# tests/CMakeFiles/so_butterworth_bpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_butterworth_bpf_test.dir/build.make
# tests/CMakeFiles/so_butterworth_bpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_butterworth_bpf_test.dir/flags.make
# tests/CMakeFiles/so_butterworth_bpf_test.dir/so_butterworth_bpf_test.cpp.o
# tests/CMakeFiles/so_butterworth_bpf_test.dir/link.txt
# tests/CMakeFiles/so_butterworth_bpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_butterworth_bpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_butterworth_bpf_test.dir/DependInfo.cmake
# tests/CMakeFiles/so_hpf_test.dir/progress.make
# tests/CMakeFiles/so_hpf_test.dir/depend.make
# tests/CMakeFiles/so_hpf_test.dir/so_hpf_test.cpp.o.d
# tests/CMakeFiles/so_hpf_test.dir/compiler_depend.make
# tests/CMakeFiles/so_hpf_test.dir/so_hpf_test.cpp.o
# tests/CMakeFiles/so_hpf_test.dir/build.make
# tests/CMakeFiles/so_hpf_test.dir/compiler_depend.internal
# tests/CMakeFiles/so_hpf_test.dir/flags.make
# tests/CMakeFiles/so_hpf_test.dir/link.txt
# tests/CMakeFiles/so_hpf_test.dir/compiler_depend.ts
# tests/CMakeFiles/so_hpf_test.dir/cmake_clean.cmake
# tests/CMakeFiles/so_hpf_test.dir/DependInfo.cmake
# install_manifest.txt
# lib/libgtest.so
# lib/libgtest_main.so
# googletest-build/cmake_install.cmake
# googletest-build/googlemock/cmake_install.cmake
# googletest-build/googlemock/CTestTestfile.cmake
# googletest-build/googlemock/Makefile
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/progress.make
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/depend.make
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/compiler_depend.make
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/build.make
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/flags.make
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/link.txt
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/compiler_depend.ts
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/cmake_clean.cmake
# googletest-build/googlemock/CMakeFiles/gmock_main.dir/DependInfo.cmake
# googletest-build/googlemock/CMakeFiles/CMakeDirectoryInformation.cmake
# googletest-build/googlemock/CMakeFiles/progress.marks
# googletest-build/googlemock/CMakeFiles/gmock.dir/progress.make
# googletest-build/googlemock/CMakeFiles/gmock.dir/depend.make
# googletest-build/googlemock/CMakeFiles/gmock.dir/compiler_depend.make
# googletest-build/googlemock/CMakeFiles/gmock.dir/build.make
# googletest-build/googlemock/CMakeFiles/gmock.dir/flags.make
# googletest-build/googlemock/CMakeFiles/gmock.dir/link.txt
# googletest-build/googlemock/CMakeFiles/gmock.dir/compiler_depend.ts
# googletest-build/googlemock/CMakeFiles/gmock.dir/cmake_clean.cmake
# googletest-build/googlemock/CMakeFiles/gmock.dir/DependInfo.cmake
# googletest-build/CTestTestfile.cmake
# googletest-build/Makefile
# googletest-build/CMakeFiles/CMakeDirectoryInformation.cmake
# googletest-build/CMakeFiles/progress.marks
# googletest-build/googletest/cmake_install.cmake
# googletest-build/googletest/generated/gmock.pc
# googletest-build/googletest/generated/gtest_main.pc
# googletest-build/googletest/generated/gtest.pc
# googletest-build/googletest/generated/GTestConfig.cmake
# googletest-build/googletest/generated/gmock_main.pc
# googletest-build/googletest/generated/GTestConfigVersion.cmake
# googletest-build/googletest/CTestTestfile.cmake
# googletest-build/googletest/Makefile
# googletest-build/googletest/CMakeFiles/gtest_main.dir/progress.make
# googletest-build/googletest/CMakeFiles/gtest_main.dir/depend.make
# googletest-build/googletest/CMakeFiles/gtest_main.dir/src/gtest_main.cc.o.d
# googletest-build/googletest/CMakeFiles/gtest_main.dir/src/gtest_main.cc.o
# googletest-build/googletest/CMakeFiles/gtest_main.dir/compiler_depend.make
# googletest-build/googletest/CMakeFiles/gtest_main.dir/build.make
# googletest-build/googletest/CMakeFiles/gtest_main.dir/compiler_depend.internal
# googletest-build/googletest/CMakeFiles/gtest_main.dir/flags.make
# googletest-build/googletest/CMakeFiles/gtest_main.dir/link.txt
# googletest-build/googletest/CMakeFiles/gtest_main.dir/compiler_depend.ts
# googletest-build/googletest/CMakeFiles/gtest_main.dir/cmake_clean.cmake
# googletest-build/googletest/CMakeFiles/gtest_main.dir/DependInfo.cmake
# googletest-build/googletest/CMakeFiles/gtest.dir/progress.make
# googletest-build/googletest/CMakeFiles/gtest.dir/depend.make
# googletest-build/googletest/CMakeFiles/gtest.dir/src/gtest-all.cc.o.d
# googletest-build/googletest/CMakeFiles/gtest.dir/src/gtest-all.cc.o
# googletest-build/googletest/CMakeFiles/gtest.dir/compiler_depend.make
# googletest-build/googletest/CMakeFiles/gtest.dir/build.make
# googletest-build/googletest/CMakeFiles/gtest.dir/compiler_depend.internal
# googletest-build/googletest/CMakeFiles/gtest.dir/flags.make
# googletest-build/googletest/CMakeFiles/gtest.dir/link.txt
# googletest-build/googletest/CMakeFiles/gtest.dir/compiler_depend.ts
# googletest-build/googletest/CMakeFiles/gtest.dir/cmake_clean.cmake
# googletest-build/googletest/CMakeFiles/gtest.dir/DependInfo.cmake
# googletest-build/googletest/CMakeFiles/CMakeDirectoryInformation.cmake
# googletest-build/googletest/CMakeFiles/Export/lib/cmake/GTest/GTestTargets-release.cmake
# googletest-build/googletest/CMakeFiles/Export/lib/cmake/GTest/GTestTargets.cmake
# googletest-build/googletest/CMakeFiles/progress.marks
# googletest-download/cmake_install.cmake
# googletest-download/CMakeCache.txt
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-build
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-download
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-mkdir
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-install
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-done
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-test
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-gitclone-lastrun.txt
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-gitinfo.txt
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-patch
# googletest-download/googletest-prefix/src/googletest-stamp/googletest-configure
# googletest-download/googletest-prefix/tmp/googletest-gitupdate.cmake
# googletest-download/googletest-prefix/tmp/googletest-cfgcmd.txt.in
# googletest-download/googletest-prefix/tmp/googletest-gitclone.cmake
# googletest-download/googletest-prefix/tmp/googletest-cfgcmd.txt
# googletest-download/CMakeLists.txt
# googletest-download/Makefile
# googletest-download/CMakeFiles/CMakeOutput.log
# googletest-download/CMakeFiles/googletest.dir/progress.make
# googletest-download/CMakeFiles/googletest.dir/compiler_depend.make
# googletest-download/CMakeFiles/googletest.dir/build.make
# googletest-download/CMakeFiles/googletest.dir/Labels.json
# googletest-download/CMakeFiles/googletest.dir/Labels.txt
# googletest-download/CMakeFiles/googletest.dir/compiler_depend.ts
# googletest-download/CMakeFiles/googletest.dir/cmake_clean.cmake
# googletest-download/CMakeFiles/googletest.dir/DependInfo.cmake
# googletest-download/CMakeFiles/3.21.20210928-g09dd52c/CMakeSystem.cmake
# googletest-download/CMakeFiles/Makefile2
# googletest-download/CMakeFiles/CMakeRuleHashes.txt
# googletest-download/CMakeFiles/CMakeDirectoryInformation.cmake
# googletest-download/CMakeFiles/cmake.check_cache
# googletest-download/CMakeFiles/googletest-complete
# googletest-download/CMakeFiles/progress.marks
# googletest-download/CMakeFiles/Makefile.cmake
# googletest-download/CMakeFiles/TargetDirectories.txt
# share/doc/DSP-Cpp-filters/COPYING.MIT
# googletest-src/WORKSPACE
# googletest-src/googlemock/src/gmock-spec-builders.cc
# googletest-src/googlemock/src/gmock-cardinalities.cc
# googletest-src/googlemock/src/gmock_main.cc
# googletest-src/googlemock/src/gmock-all.cc
# googletest-src/googlemock/src/gmock-matchers.cc
# googletest-src/googlemock/src/gmock-internal-utils.cc
# googletest-src/googlemock/src/gmock.cc
# googletest-src/googlemock/include/gmock/gmock-matchers.h
# googletest-src/googlemock/include/gmock/gmock-function-mocker.h
# googletest-src/googlemock/include/gmock/internal/gmock-pp.h
# googletest-src/googlemock/include/gmock/internal/gmock-internal-utils.h
# googletest-src/googlemock/include/gmock/internal/gmock-port.h
# googletest-src/googlemock/include/gmock/internal/custom/gmock-port.h
# googletest-src/googlemock/include/gmock/internal/custom/gmock-matchers.h
# googletest-src/googlemock/include/gmock/internal/custom/gmock-generated-actions.h
# googletest-src/googlemock/include/gmock/internal/custom/README.md
# googletest-src/googlemock/include/gmock/internal/custom/gmock-generated-actions.h.pump
# googletest-src/googlemock/include/gmock/gmock-generated-actions.h
# googletest-src/googlemock/include/gmock/gmock-generated-function-mockers.h
# googletest-src/googlemock/include/gmock/gmock-more-actions.h
# googletest-src/googlemock/include/gmock/gmock-more-matchers.h
# googletest-src/googlemock/include/gmock/gmock-nice-strict.h
# googletest-src/googlemock/include/gmock/gmock-generated-function-mockers.h.pump
# googletest-src/googlemock/include/gmock/gmock.h
# googletest-src/googlemock/include/gmock/gmock-cardinalities.h
# googletest-src/googlemock/include/gmock/gmock-spec-builders.h
# googletest-src/googlemock/include/gmock/gmock-actions.h
# googletest-src/googlemock/include/gmock/gmock-generated-actions.h.pump
# googletest-src/googlemock/include/gmock/gmock-generated-matchers.h
# googletest-src/googlemock/include/gmock/gmock-generated-matchers.h.pump
# googletest-src/googlemock/LICENSE
# googletest-src/googlemock/README.md
# googletest-src/googlemock/CMakeLists.txt
# googletest-src/googlemock/scripts/upload_gmock.py
# googletest-src/googlemock/scripts/upload.py
# googletest-src/googlemock/scripts/generator/README.cppclean
# googletest-src/googlemock/scripts/generator/LICENSE
# googletest-src/googlemock/scripts/generator/cpp/utils.py
# googletest-src/googlemock/scripts/generator/cpp/tokenize.py
# googletest-src/googlemock/scripts/generator/cpp/gmock_class.py
# googletest-src/googlemock/scripts/generator/cpp/gmock_class_test.py
# googletest-src/googlemock/scripts/generator/cpp/keywords.py
# googletest-src/googlemock/scripts/generator/cpp/ast.py
# googletest-src/googlemock/scripts/generator/cpp/__init__.py
# googletest-src/googlemock/scripts/generator/gmock_gen.py
# googletest-src/googlemock/scripts/generator/README
# googletest-src/googlemock/scripts/gmock-config.in
# googletest-src/googlemock/scripts/gmock_doctor.py
# googletest-src/googlemock/scripts/fuse_gmock_files.py
# googletest-src/googlemock/cmake/gmock.pc.in
# googletest-src/googlemock/cmake/gmock_main.pc.in
# googletest-src/googlemock/docs/cheat_sheet.md
# googletest-src/googlemock/docs/cook_book.md
# googletest-src/googlemock/docs/for_dummies.md
# googletest-src/googlemock/docs/gmock_faq.md
# googletest-src/googlemock/test/gmock_output_test_.cc
# googletest-src/googlemock/test/gmock_all_test.cc
# googletest-src/googlemock/test/gmock_link_test.cc
# googletest-src/googlemock/test/gmock_leak_test.py
# googletest-src/googlemock/test/gmock_output_test.py
# googletest-src/googlemock/test/gmock_link_test.h
# googletest-src/googlemock/test/gmock-more-actions_test.cc
# googletest-src/googlemock/test/gmock-port_test.cc
# googletest-src/googlemock/test/gmock-pp_test.cc
# googletest-src/googlemock/test/gmock-generated-function-mockers_test.cc
# googletest-src/googlemock/test/gmock-generated-matchers_test.cc
# googletest-src/googlemock/test/gmock-generated-actions_test.cc
# googletest-src/googlemock/test/gmock_output_test_golden.txt
# googletest-src/googlemock/test/BUILD.bazel
# googletest-src/googlemock/test/gmock-function-mocker_nc_test.py
# googletest-src/googlemock/test/gmock-function-mocker_nc.cc
# googletest-src/googlemock/test/gmock-cardinalities_test.cc
# googletest-src/googlemock/test/gmock-actions_test.cc
# googletest-src/googlemock/test/gmock-matchers_test.cc
# googletest-src/googlemock/test/gmock_stress_test.cc
# googletest-src/googlemock/test/gmock-pp-string_test.cc
# googletest-src/googlemock/test/gmock-nice-strict_test.cc
# googletest-src/googlemock/test/gmock_test.cc
# googletest-src/googlemock/test/gmock_test_utils.py
# googletest-src/googlemock/test/gmock-spec-builders_test.cc
# googletest-src/googlemock/test/gmock-internal-utils_test.cc
# googletest-src/googlemock/test/gmock_ex_test.cc
# googletest-src/googlemock/test/gmock_link2_test.cc
# googletest-src/googlemock/test/gmock_leak_test_.cc
# googletest-src/googlemock/test/gmock-function-mocker_test.cc
# googletest-src/googlemock/CONTRIBUTORS
# googletest-src/.gitignore
# googletest-src/LICENSE
# googletest-src/README.md
# googletest-src/CMakeLists.txt
# googletest-src/appveyor.yml
# googletest-src/.git/index
# googletest-src/.git/HEAD
# googletest-src/.git/packed-refs
# googletest-src/.git/config
# googletest-src/.git/description
# googletest-src/.git/hooks/fsmonitor-watchman.sample
# googletest-src/.git/hooks/push-to-checkout.sample
# googletest-src/.git/hooks/update.sample
# googletest-src/.git/hooks/pre-applypatch.sample
# googletest-src/.git/hooks/pre-push.sample
# googletest-src/.git/hooks/pre-receive.sample
# googletest-src/.git/hooks/pre-merge-commit.sample
# googletest-src/.git/hooks/applypatch-msg.sample
# googletest-src/.git/hooks/pre-commit.sample
# googletest-src/.git/hooks/prepare-commit-msg.sample
# googletest-src/.git/hooks/commit-msg.sample
# googletest-src/.git/hooks/post-update.sample
# googletest-src/.git/hooks/pre-rebase.sample
# googletest-src/.git/objects/pack/pack-abbb6a6db347430ede78c4b2ede93963508e9f4e.pack
# googletest-src/.git/objects/pack/pack-abbb6a6db347430ede78c4b2ede93963508e9f4e.idx
# googletest-src/.git/info/exclude
# googletest-src/.git/refs/remotes/origin/HEAD
# googletest-src/.git/refs/heads/main
# googletest-src/.git/logs/HEAD
# googletest-src/.git/logs/refs/remotes/origin/HEAD
# googletest-src/.git/logs/refs/heads/main
# googletest-src/library.json
# googletest-src/BUILD.bazel
# googletest-src/.clang-format
# googletest-src/.travis.yml
# googletest-src/ci/install-osx.sh
# googletest-src/ci/build-platformio.sh
# googletest-src/ci/travis.sh
# googletest-src/ci/build-linux-bazel.sh
# googletest-src/ci/install-linux.sh
# googletest-src/ci/install-platformio.sh
# googletest-src/ci/env-linux.sh
# googletest-src/ci/env-osx.sh
# googletest-src/ci/get-nprocessors.sh
# googletest-src/ci/log-config.sh
# googletest-src/CONTRIBUTING.md
# googletest-src/platformio.ini
# googletest-src/googletest/src/gtest.cc
# googletest-src/googletest/src/gtest-printers.cc
# googletest-src/googletest/src/gtest-test-part.cc
# googletest-src/googletest/src/gtest-matchers.cc
# googletest-src/googletest/src/gtest-filepath.cc
# googletest-src/googletest/src/gtest_main.cc
# googletest-src/googletest/src/gtest-death-test.cc
# googletest-src/googletest/src/gtest-port.cc
# googletest-src/googletest/src/gtest-all.cc
# googletest-src/googletest/src/gtest-typed-test.cc
# googletest-src/googletest/src/gtest-internal-inl.h
# googletest-src/googletest/include/gtest/gtest-param-test.h
# googletest-src/googletest/include/gtest/internal/gtest-port-arch.h
# googletest-src/googletest/include/gtest/internal/gtest-string.h
# googletest-src/googletest/include/gtest/internal/gtest-death-test-internal.h
# googletest-src/googletest/include/gtest/internal/gtest-type-util.h.pump
# googletest-src/googletest/include/gtest/internal/gtest-type-util.h
# googletest-src/googletest/include/gtest/internal/gtest-port.h
# googletest-src/googletest/include/gtest/internal/gtest-internal.h
# googletest-src/googletest/include/gtest/internal/gtest-param-util.h
# googletest-src/googletest/include/gtest/internal/gtest-filepath.h
# googletest-src/googletest/include/gtest/internal/custom/README.md
# googletest-src/googletest/include/gtest/internal/custom/gtest.h
# googletest-src/googletest/include/gtest/internal/custom/gtest-port.h
# googletest-src/googletest/include/gtest/internal/custom/gtest-printers.h
# googletest-src/googletest/include/gtest/gtest-matchers.h
# googletest-src/googletest/include/gtest/gtest-death-test.h
# googletest-src/googletest/include/gtest/gtest-spi.h
# googletest-src/googletest/include/gtest/gtest.h
# googletest-src/googletest/include/gtest/gtest-test-part.h
# googletest-src/googletest/include/gtest/gtest-typed-test.h
# googletest-src/googletest/include/gtest/gtest_prod.h
# googletest-src/googletest/include/gtest/gtest_pred_impl.h
# googletest-src/googletest/include/gtest/gtest-message.h
# googletest-src/googletest/include/gtest/gtest-printers.h
# googletest-src/googletest/LICENSE
# googletest-src/googletest/README.md
# googletest-src/googletest/CMakeLists.txt
# googletest-src/googletest/scripts/gen_gtest_pred_impl.py
# googletest-src/googletest/scripts/upload.py
# googletest-src/googletest/scripts/fuse_gtest_files.py
# googletest-src/googletest/scripts/gtest-config.in
# googletest-src/googletest/scripts/common.py
# googletest-src/googletest/scripts/upload_gtest.py
# googletest-src/googletest/scripts/test/Makefile
# googletest-src/googletest/scripts/release_docs.py
# googletest-src/googletest/scripts/pump.py
# googletest-src/googletest/cmake/gtest_main.pc.in
# googletest-src/googletest/cmake/libgtest.la.in
# googletest-src/googletest/cmake/internal_utils.cmake
# googletest-src/googletest/cmake/Config.cmake.in
# googletest-src/googletest/cmake/gtest.pc.in
# googletest-src/googletest/docs/samples.md
# googletest-src/googletest/docs/primer.md
# googletest-src/googletest/docs/faq.md
# googletest-src/googletest/docs/pump_manual.md
# googletest-src/googletest/docs/advanced.md
# googletest-src/googletest/docs/pkgconfig.md
# googletest-src/googletest/samples/sample3_unittest.cc
# googletest-src/googletest/samples/sample4.h
# googletest-src/googletest/samples/sample1.h
# googletest-src/googletest/samples/sample4.cc
# googletest-src/googletest/samples/sample6_unittest.cc
# googletest-src/googletest/samples/sample9_unittest.cc
# googletest-src/googletest/samples/sample5_unittest.cc
# googletest-src/googletest/samples/sample10_unittest.cc
# googletest-src/googletest/samples/sample2.h
# googletest-src/googletest/samples/sample4_unittest.cc
# googletest-src/googletest/samples/sample1.cc
# googletest-src/googletest/samples/sample8_unittest.cc
# googletest-src/googletest/samples/sample2.cc
# googletest-src/googletest/samples/sample1_unittest.cc
# googletest-src/googletest/samples/sample7_unittest.cc
# googletest-src/googletest/samples/prime_tables.h
# googletest-src/googletest/samples/sample2_unittest.cc
# googletest-src/googletest/samples/sample3-inl.h
# googletest-src/googletest/test/googletest-catch-exceptions-test.py
# googletest-src/googletest/test/googletest-death-test-test.cc
# googletest-src/googletest/test/gtest_skip_in_environment_setup_test.cc
# googletest-src/googletest/test/gtest_stress_test.cc
# googletest-src/googletest/test/googletest-output-test_.cc
# googletest-src/googletest/test/googletest-test2_test.cc
# googletest-src/googletest/test/googletest-throw-on-failure-test.py
# googletest-src/googletest/test/googletest-color-test_.cc
# googletest-src/googletest/test/gtest_sole_header_test.cc
# googletest-src/googletest/test/googletest-param-test2-test.cc
# googletest-src/googletest/test/googletest-env-var-test.py
# googletest-src/googletest/test/gtest_testbridge_test.py
# googletest-src/googletest/test/googletest-uninitialized-test.py
# googletest-src/googletest/test/gtest_list_output_unittest.py
# googletest-src/googletest/test/gtest_testbridge_test_.cc
# googletest-src/googletest/test/gtest_environment_test.cc
# googletest-src/googletest/test/googletest-shuffle-test.py
# googletest-src/googletest/test/gtest_list_output_unittest_.cc
# googletest-src/googletest/test/googletest-param-test-invalid-name1-test_.cc
# googletest-src/googletest/test/gtest_unittest.cc
# googletest-src/googletest/test/googletest-param-test-test.cc
# googletest-src/googletest/test/googletest-output-test-golden-lin.txt
# googletest-src/googletest/test/googletest-port-test.cc
# googletest-src/googletest/test/gtest_xml_outfile1_test_.cc
# googletest-src/googletest/test/gtest_test_macro_stack_footprint_test.cc
# googletest-src/googletest/test/googletest-output-test.py
# googletest-src/googletest/test/googletest-list-tests-unittest_.cc
# googletest-src/googletest/test/googletest-break-on-failure-unittest.py
# googletest-src/googletest/test/googletest-catch-exceptions-test_.cc
# googletest-src/googletest/test/gtest_xml_output_unittest.py
# googletest-src/googletest/test/googletest-param-test-invalid-name1-test.py
# googletest-src/googletest/test/gtest_help_test.py
# googletest-src/googletest/test/gtest_all_test.cc
# googletest-src/googletest/test/BUILD.bazel
# googletest-src/googletest/test/googletest-json-output-unittest.py
# googletest-src/googletest/test/googletest-message-test.cc
# googletest-src/googletest/test/gtest_skip_environment_check_output_test.py
# googletest-src/googletest/test/googletest-env-var-test_.cc
# googletest-src/googletest/test/googletest-listener-test.cc
# googletest-src/googletest/test/gtest-typed-test_test.cc
# googletest-src/googletest/test/googletest-filter-unittest.py
# googletest-src/googletest/test/googletest-break-on-failure-unittest_.cc
# googletest-src/googletest/test/googletest-options-test.cc
# googletest-src/googletest/test/googletest-filter-unittest_.cc
# googletest-src/googletest/test/gtest_help_test_.cc
# googletest-src/googletest/test/gtest-typed-test2_test.cc
# googletest-src/googletest/test/gtest_json_test_utils.py
# googletest-src/googletest/test/googletest-test-part-test.cc
# googletest-src/googletest/test/googletest-param-test-test.h
# googletest-src/googletest/test/googletest-death-test_ex_test.cc
# googletest-src/googletest/test/gtest_assert_by_exception_test.cc
# googletest-src/googletest/test/googletest-color-test.py
# googletest-src/googletest/test/gtest_main_unittest.cc
# googletest-src/googletest/test/gtest_xml_outfile2_test_.cc
# googletest-src/googletest/test/gtest_test_utils.py
# googletest-src/googletest/test/gtest_pred_impl_unittest.cc
# googletest-src/googletest/test/gtest_throw_on_failure_ex_test.cc
# googletest-src/googletest/test/gtest_xml_test_utils.py
# googletest-src/googletest/test/gtest_repeat_test.cc
# googletest-src/googletest/test/googletest-uninitialized-test_.cc
# googletest-src/googletest/test/gtest_prod_test.cc
# googletest-src/googletest/test/googletest-json-outfiles-test.py
# googletest-src/googletest/test/googletest-throw-on-failure-test_.cc
# googletest-src/googletest/test/gtest_skip_test.cc
# googletest-src/googletest/test/gtest_premature_exit_test.cc
# googletest-src/googletest/test/production.cc
# googletest-src/googletest/test/production.h
# googletest-src/googletest/test/gtest-typed-test_test.h
# googletest-src/googletest/test/gtest_xml_outfiles_test.py
# googletest-src/googletest/test/googletest-shuffle-test_.cc
# googletest-src/googletest/test/googletest-filepath-test.cc
# googletest-src/googletest/test/googletest-param-test-invalid-name2-test.py
# googletest-src/googletest/test/gtest_xml_output_unittest_.cc
# googletest-src/googletest/test/gtest-unittest-api_test.cc
# googletest-src/googletest/test/googletest-list-tests-unittest.py
# googletest-src/googletest/test/gtest_no_test_unittest.cc
# googletest-src/googletest/test/googletest-param-test-invalid-name2-test_.cc
# googletest-src/googletest/test/googletest-printers-test.cc
# googletest-src/googletest/CONTRIBUTORS
# Makefile
# aarch64-linux-android.cmake
# CMakeFiles/CMakeOutput.log
# CMakeFiles/3.21.20210928-g09dd52c/CMakeDetermineCompilerABI_C.bin
# CMakeFiles/3.21.20210928-g09dd52c/CMakeCXXCompiler.cmake
# CMakeFiles/3.21.20210928-g09dd52c/CMakeCCompiler.cmake
# CMakeFiles/3.21.20210928-g09dd52c/CompilerIdCXX/CMakeCXXCompilerId.o
# CMakeFiles/3.21.20210928-g09dd52c/CompilerIdCXX/CMakeCXXCompilerId.cpp
# CMakeFiles/3.21.20210928-g09dd52c/CompilerIdC/CMakeCCompilerId.o
# CMakeFiles/3.21.20210928-g09dd52c/CompilerIdC/CMakeCCompilerId.c
# CMakeFiles/3.21.20210928-g09dd52c/CMakeSystem.cmake
# CMakeFiles/3.21.20210928-g09dd52c/CMakeDetermineCompilerABI_CXX.bin
# CMakeFiles/Makefile2
# CMakeFiles/CMakeRuleHashes.txt
# CMakeFiles/CMakeDirectoryInformation.cmake
# CMakeFiles/cmake.check_cache
# CMakeFiles/CMakeError.log
# CMakeFiles/progress.marks
# CMakeFiles/Makefile.cmake
# CMakeFiles/TargetDirectories.txt
