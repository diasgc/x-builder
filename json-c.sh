#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   .   .   .   .   .   .  static
#  .   .   .   .   +   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='json-c'
dsc='Description: A JSON implementation in C'
lic='MIT'
src='https://github.com/json-c/json-c.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='80'
pkg='json-c'

eta='60'
lsz=
psz=
ets=(30 0 0 0 27 0 0 0 0 0 0)
ls0=(487 0 0 0 187 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb1
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain

# CMAKE OPTIONS
# DISABLE_STATIC_FPIC	Bool	The default builds position independent code. Set this to OFF to create a shared library only.
# DISABLE_BSYMBOLIC	Bool	Disable use of -Bsymbolic-functions.
# DISABLE_THREAD_LOCAL_STORAGE	Bool	Disable use of Thread-Local Storage (HAVE___THREAD).
# DISABLE_WERROR	Bool	Disable use of -Werror.
# ENABLE_RDRAND	Bool	Enable RDRAND Hardware RNG Hash Seed.
# ENABLE_THREADING	Bool	Enable partial threading support.
# OVERRIDE_GET_RANDOM_SEED  Override json_c_get_random_seed() with custom code.
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start