#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  E   .   .   .   .   +   +   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   +   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='mbedtls'
dsc='An open source, portable, easy to use, readable and flexible SSL library.'
lic='Apache-2.0'
src='https://github.com/ARMmbed/mbedtls.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='mbedtls'

eta='22'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DUSE_SHARED_MBEDTLS_LIBRARY=OFF"
cs1="-DUSE_SHARED_MBEDTLS_LIBRARY=ON"
cb0="-DENABLE_PROGRAMS=OFF"
cb1="-DENABLE_PROGRAMS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="-DENABLE_ZLIB_SUPPORT=OFF -DENABLE_TESTING=OFF -DUNSAFE_BUILD=OFF -DMBEDTLS_FATAL_WARNINGS=ON -DLINK_WITH_PTHREAD=OFF -DLINK_WITH_TRUSTED_STORAGE=OFF"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start