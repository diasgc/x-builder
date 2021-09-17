#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='jsoncpp'
dsc='A C++ library for interacting with JSON.'
lic='MIT'
src='https://github.com/open-source-parsers/jsoncpp.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='jsoncpp'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=
CBN=
CFG="-DBUILD_TESTING=OFF -DJSONCPP_WITH_EXAMPLE=OFF -DJSONCPP_WITH_TESTS=OFF"
# -----------------------------------------

# -DBUILD_OBJECT_LIBS -DBUILD_SHARED_LIBS -DBUILD_STATIC_LIBS -DBUILD_TESTING -DJSONCPP_WITH_EXAMPLE
. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start