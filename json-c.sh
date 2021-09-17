#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   .   .   .   .   .   .  static
#  +   .   .   .   +   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='json-c'
dsc='Description: A JSON implementation in C'
lic='MIT'
src='https://github.com/json-c/json-c.git'
sty='git'
cfg='cm'
eta='80'

. xbuilder.sh

# CMAKE OPTIONS
# DISABLE_STATIC_FPIC	Bool	The default builds position independent code. Set this to OFF to create a shared library only.
# DISABLE_BSYMBOLIC	Bool	Disable use of -Bsymbolic-functions.
# DISABLE_THREAD_LOCAL_STORAGE	Bool	Disable use of Thread-Local Storage (HAVE___THREAD).
# DISABLE_WERROR	Bool	Disable use of -Werror.
# ENABLE_RDRAND	Bool	Enable RDRAND Hardware RNG Hash Seed.
# ENABLE_THREADING	Bool	Enable partial threading support.
# OVERRIDE_GET_RANDOM_SEED  Override json_c_get_random_seed() with custom code.

start

# Filelist
# --------

# include/json-c/json_object.h
# include/json-c/json_tokener.h
# include/json-c/printbuf.h
# include/json-c/linkhash.h
# include/json-c/json_visit.h
# include/json-c/json_inttypes.h
# include/json-c/json_object_iterator.h
# include/json-c/json_c_version.h
# include/json-c/json_pointer.h
# include/json-c/json.h
# include/json-c/json_types.h
# include/json-c/arraylist.h
# include/json-c/json_util.h
# include/json-c/debug.h
# include/json-c/json_config.h
# lib/pkgconfig/json-c.pc
# lib/libjson-c.so
# lib/cmake/json-c/json-c-targets-release.cmake
# lib/cmake/json-c/json-c-config.cmake
# lib/cmake/json-c/json-c-targets.cmake
# lib/libjson-c.a
