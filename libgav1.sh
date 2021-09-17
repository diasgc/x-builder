#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86 (static/shared)
#  ++  .   .   .   +-  .   ++  .
#
# HEADER-----------------------------------
lib='libgav1'
dsc='Main profile (0) & High profile (1) compliant AV1 decoder'
lic='BSD'
src='https://chromium.googlesource.com/codecs/libgav1'
sty='git'
cfg='cm'
tls=''
dep=''
eta='60'
pkg='libgav1'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
# defaults
CSH=$cs0
CBN=$cb1
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG=
dbld=$SRCDIR/build_${arch}
# END--------------------------------------

loadToolchain

TC="$(pwd)/cmake/${arch}"
#[ "$arch"=="*mingw32" ] && TC="$TC-posix"
CFG="-DCMAKE_TOOLCHAIN_FILE=$TC.cmake $CFG"

patchSrc(){
    pushd $SRCDIR >/dev/null
    gitClone https://github.com/abseil/abseil-cpp.git third_party/abseil-cpp
    popd >/dev/null
}

start