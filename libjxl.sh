#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  F   .   .   .   .   .   .   .   .   .   .  shared
#  F   .   .   .   .   .   .   .   .   .   .  bin

# ISSUES -------------------------------------
#  - AARCH64-ANDROID third_party/highway/tests/convert_test: 1: ^?ELF^B^A^A^C�^A��@У^F@8: not found

lib='libjxl'
dsc='A fast, compressed, persistent binary data store library for C.'
lic='BSD-3c'
src='https://github.com/libjxl/libjxl.git'
sty='git'
cfg='cm'
eta='164'

. xbuilder.sh

source_patch(){
    pushdir $SRCDIR
    doLog 'submodule' git submodule update --init --recursive
    popdir
}

start

# CMAKE OPTIONS
# -DJPEGXL_ENABLE_BENCHMARK          ON
# -DJPEGXL_ENABLE_COVERAGE           OFF
# -DJPEGXL_ENABLE_DEVTOOLS           OFF
# -DJPEGXL_ENABLE_EXAMPLES           ON
# -DJPEGXL_ENABLE_FUZZERS            OFF
# -DJPEGXL_ENABLE_JNI                ON
# -DJPEGXL_ENABLE_MANPAGES           ON
# -DJPEGXL_ENABLE_OPENEXR            ON
# -DJPEGXL_ENABLE_PLUGINS            OFF
# -DJPEGXL_ENABLE_PROFILER           OFF
# -DJPEGXL_ENABLE_SJPEG              ON
# -DJPEGXL_ENABLE_SKCMS              ON
# -DJPEGXL_ENABLE_TCMALLOC           OFF
# -DJPEGXL_ENABLE_TOOLS              ON
# -DJPEGXL_ENABLE_TRANSCODE_JPEG     ON
# -DJPEGXL_ENABLE_VIEWERS            OFF
# -DJPEGXL_FORCE_NEON                OFF
# -DJPEGXL_FORCE_SYSTEM_BROTLI       OFF
# -DJPEGXL_FORCE_SYSTEM_GTEST        OFF
# -DJPEGXL_FORCE_SYSTEM_HWY          OFF
# -DJPEGXL_STATIC                    OFF
# -DGXL_WARNINGS_AS_ERRORS           OFF
# -DSJPEG_BUILD_EXAMPLES             OFF
# -DSJPEG_ENABLE_SIMD                ON
