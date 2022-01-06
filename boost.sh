#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   V   F   F   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

# WARNING: repo size 1.5GB 45min @3mbps

lib='boost'
dsc='Super-project for modularized Boost'
lic='BSD-1c'
src='https://github.com/boostorg/boost.git'
#vrs='boost-1.78.0'
cfg='cmake'
eta='1095'

# see https://github.com/moritz-wundke/Boost-for-Android for android
. xbuilder.sh

source_get(){
    git clone --recursive https://github.com/boostorg/boost.git ${lib}
    pushd ${lib}
    git checkout master # or whatever branch you want to use
    ./bootstrap.sh
    ./b2 headers
}

echo "using clang : $arch : $CXX : <linkflags>-L$LIBSDIR/lib ; " >>$SRCDIR/project-config.jam

build_config(){
    #./bootstrap.sh --with-toolset=clang
    CXXFLAGS+=" -std=c++14 -stdlib=libc++"
    local toolset="$(os_fromid clang gnu clang)-$(arch_fromid aarch64 arm i686 x86_64)"
    local b_arch=$(arch_fromid arm arm x86 x86)
    local b_abi=$(arch_fromid aapcs aapcs sysv sysv)
    local b_bits=$(arch_fromid 64 32 32 64)
    cd $SRCDIR
    ./b2 target-os=android -j${HOST_NPROC} \
		include=$LIBSDIR/include \
		toolset="clang-$arch" \
		--prefix="$LIBSDIR"  \
		-q \
		--without-stacktrace \
		--disable-icu \
		-sNO_ZSTD=1 \
		cxxflags="$CXXFLAGS" \
		linkflags="$LDFLAGS" \
		architecture="$b_arch" \
		abi="$b_abi" \
		address-model="$b_bits" \
		boost.locale.icu=off \
		binary-format=elf \
		threading=multi \
		install
}

start