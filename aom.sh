#!/bin/bash

# v3.2.0      a8  a7  x86 x64
# ndk-clang   +++ +++ +++ +++
# linux-gnu   +++ +++ ... +.+
# mingw-llvm  +.+ ... ... +.++

lib='aom'
apt='libaom0'
dsc='Alliance for Open Media AV1 codec'
lic='BSD-2c'
src='https://aomedia.googlesource.com/aom' sty='git'
cfg='cmake'
tls='perl'
eta='200'
cst0="-DCONFIG_STATIC=0"
cst1="-DCONFIG_STATIC=1"
csh0="-DCONFIG_SHARED=0"
csh1="-DCONFIG_SHARED=1"
cbk='ENABLE_EXAMPLES'
CFG='-DENABLE_TESTS=OFF
     -DENABLE_TOOLS=OFF
     -DENABLE_TESTDATA=OFF
     -DENABLE_DOCS=OFF'

lst_inc='aom/aom_decoder.h aom/aom_integer.h aom/aom_external_partition.h
         aom/aom_frame_buffer.h aom/aom_image.h aom/aom.h aom/aom_encoder.h
         aom/aomcx.h aom/aom_codec.h aom/aomdx.h'
lst_lib='libaom'
lst_bin='aomdec aomenc'

. xbuilder.sh

$host_arm && CFG+=" -DCONFIG_RUNTIME_CPU_DETECT=0 -DAS_EXECUTABLE=$AS"
$host_arm64 && CFG+="  -DAOM_NEON_INTRIN_FLAG=" || CFG+=" -DAOM_NEON_INTRIN_FLAG=-mfpu=neon"
$host_x86 && CFG+=' -DCMAKE_C_COMPILER_ARG1=-m32 -DCMAKE_CXX_COMPILER_ARG1=-m32'
$host_mingw && CFG+=" -DCONFIG_PIC=1"

start

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