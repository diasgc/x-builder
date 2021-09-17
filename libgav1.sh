#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libgav1'
dsc='Main profile (0) & High profile (1) compliant AV1 decoder'
lic='BSD'
src='https://chromium.googlesource.com/codecs/libgav1'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='libgav1'

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
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
CSH=$cs0
CBN=$cb1

# enable main toolchain util
. tcutils.sh

CFG=
dbld=$SRCDIR/build_${arch}
loadToolchain

TC="$(pwd)/cmake/${arch}"
#[ "$arch"=="*mingw32" ] && TC="$TC-posix"
CFG="-DCMAKE_TOOLCHAIN_FILE=$TC.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    pushd $SRCDIR >/dev/null
    gitClone https://github.com/abseil/abseil-cpp.git third_party/abseil-cpp
    popd >/dev/null
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file



start