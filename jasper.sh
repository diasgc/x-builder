#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP+ PP+ ... ... CLANG
# GNU ... PP+ ... ... GCC
# WIN ... ... ... PP+ CLANG/GCC

lib='jasper'
apt='jasper'
dsc='Image Processing/Coding Tool Kit'
lic='JasPer'
src='https://github.com/mdadams/jasper.git'
cfg='cmake'
eta='26'

cshk="JAS_ENABLE_SHARED"
cbk="JAS_ENABLE_PROGRAMS"
CFG="-DBUILD_TESTING=OFF -DJAS_ENABLE_DOC=OFF"

lst_inc='jasper/jas_malloc.h jasper/jas_version.h
	jasper/jas_dll.h jasper/jas_tmr.h
	jasper/jas_export_cmake.h jasper/jas_init.h
	jasper/jas_fix.h jasper/jas_compiler.h
	jasper/jasper.h jasper/jas_getopt.h
	jasper/jas_image.h jasper/jas_stream.h
	jasper/jas_types.h jasper/jas_string.h
	jasper/jas_icc.h jasper/jas_config.h
	jasper/jas_thread.h jasper/jas_cm.h
	jasper/jas_math.h jasper/jas_log.h
	jasper/jas_tvp.h jasper/jas_seq.h
	jasper/jas_debug.h'
lst_lib='libjasper'
lst_bin='jasper multithread imgcmp imginfo'

. xbuilder.sh

$host_mingw && CFG="-DWITH_STACK_PROTECTOR=OFF"

start


# CMAKE config options             def.val
# ALLOW_IN_SOURCE_BUILD             OFF
# BUILD_TESTING                     OFF
# JAS_ENABLE_32BIT                  OFF
# JAS_ENABLE_ASAN                   OFF
# JAS_ENABLE_AUTOMATIC_DEPENDENCIES ON

# Filelist
# --------
# include/jasper/jas_malloc.h
# include/jasper/jas_version.h
# include/jasper/jas_dll.h
# include/jasper/jas_tmr.h
# include/jasper/jas_export_cmake.h
# include/jasper/jas_init.h
# include/jasper/jas_fix.h
# include/jasper/jas_compiler.h
# include/jasper/jasper.h
# include/jasper/jas_getopt.h
# include/jasper/jas_image.h
# include/jasper/jas_stream.h
# include/jasper/jas_types.h
# include/jasper/jas_string.h
# include/jasper/jas_icc.h
# include/jasper/jas_config.h
# include/jasper/jas_thread.h
# include/jasper/jas_cm.h
# include/jasper/jas_math.h
# include/jasper/jas_log.h
# include/jasper/jas_tvp.h
# include/jasper/jas_seq.h
# include/jasper/jas_debug.h
# lib/pkgconfig/jasper.pc
# lib/libjasper.so
# share/man/man1/imginfo.1
# share/man/man1/jasper.1
# share/man/man1/imgcmp.1
# share/doc/JasPer/README
# bin/jasper
# bin/multithread
# bin/imgcmp
# bin/imginfo
