#!/bin/bash

lib='aom'
apt='libaom0'
dsc='Alliance for Open Media AV1 codec'
lic='BSD-2c'
src='https://aomedia.googlesource.com/aom.git'
cfg='cmake'
tls='perl'
eta='200'
cfg_static='CONFIG_STATIC=0|CONFIG_STATIC=1'
cfg_shared='CONFIG_SHARED=0|CONFIG_SHARED=1'
cst0="-DCONFIG_STATIC=0"
cst1="-DCONFIG_STATIC=1"
csh0="-DCONFIG_SHARED=0"
csh1="-DCONFIG_SHARED=1"
cbk='ENABLE_EXAMPLES'
CFG='-DENABLE_TESTS=OFF
     -DENABLE_TOOLS=OFF
     -DENABLE_TESTDATA=OFF
     -DENABLE_DOCS=OFF'

lst_inc='aom/*.h'
lst_lib='libaom.a libaom.so'
lst_bin='aomdec aomenc'
lst_lic='LICENSE PATENTS AUTHORS'

. xbuilder.sh

$host_arm && CFG+=" -DCONFIG_RUNTIME_CPU_DETECT=0 -DAS_EXECUTABLE=$AS"
$host_arm64 && CFG+=" -DAOM_NEON_INTRIN_FLAG="
$host_arm32 && CFG+=" -DAOM_NEON_INTRIN_FLAG=-mfpu=neon"
$host_x86 && CFG+=' -DCMAKE_C_COMPILER_ARG1=-m32 -DCMAKE_CXX_COMPILER_ARG1=-m32'
$host_mingw && CFG+=" -DCONFIG_PIC=1"

start

# v3.2.0      a8  a7  x86 x64
# ndk-clang   +++ +++ +++ +++
# linux-gnu   +++ +++ ... +.+
# mingw-llvm  +.+ ... ... +.++

# Filelist
# --------
# include/aom/aom_decoder.h
# include/aom/aom_integer.h
# include/aom/aom_external_partition.h
# include/aom/aom_frame_buffer.h
# include/aom/aom_image.h
# include/aom/aom.h
# include/aom/aom_encoder.h
# include/aom/aomcx.h
# include/aom/aom_codec.h
# include/aom/aomdx.h
# lib/libaom.a
# lib/pkgconfig/aom.pc
# lib/libaom.so
# bin/aomdec
# bin/aomenc