#!/bin/bash

lib='json-c'
dsc='Description: A JSON implementation in C'
lic='MIT'
src='https://github.com/json-c/json-c.git'
cfg='cmake'
eta='80'

lst_inc='json-c/*.h'
lst_lib='libjson-c.*'
lst_bin=''
lst_lic='COPYING AUTHORS'
lst_pc='json-c.pc'

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

# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc