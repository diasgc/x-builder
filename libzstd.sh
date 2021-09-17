#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   .   .   .   .   .   .  static
#  +   .   .   .   +   .   .   .   .   .   .  shared
#  +   .   .   .   +   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libzstd'
dsc='Zstandard - Fast real-time compression algorithm'
lic='BSD/GPL-2.0'
src='https://github.com/facebook/zstd.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='libzstd'

eta='134'
lsz=
psz=
ets=(108 0 0 0 64 0 0 0 0 0 0)
ls0=(10821 0 0 0 874 0 0 0 0 0 0)
ls1=(4441 0 0 0 775 0 0 0 0 0 0)

cs0="-DZSTD_BUILD_STATIC=ON"
cs1="-DZSTD_BUILD_SHARED=ON"
cb0="-DZSTD_BUILD_PROGRAMS=OFF"
cb1="-DZSTD_BUILD_PROGRAMS=ON"
CSH=
CBN=
# -----------------------------------------

. tcutils.sh
#CFG="-DZSTD_BUILD_TESTS=OFF -DZSTD_BUILD_CONTRIB=OFF \
#  -DZSTD_LEGACY_SUPPORT=OFF -DZSTD_LZ4_SUPPORT=OFF \
#  -DZSTD_LZMA_SUPPORT=OFF -DZSTD_ZLIB_SUPPORT=OFF \
#  -DZSTD_PROGRAMS_LINK_SHARED=OFF \
#  -DZSTD_MULTITHREAD_SUPPORT=ON"
SRCDIR=$SRCDIR/build/cmake/
dbld=$SRCDIR/${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start