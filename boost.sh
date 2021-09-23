#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   V   F   F   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

# WARNING: repo size 1.5GB 45min @3mbps

lib='boost'
dsc='Super-project for modularized Boost'
lic='GLP-2.0'
src='https://github.com/boostorg/boost.git'
sty='git'
cfg='cm'

eta='1095'

. xbuilder.sh

source_get(){
    git clone --recursive https://github.com/boostorg/boost.git ${lib}
    pushd ${lib}
    git checkout develop # or whatever branch you want to use
    ./bootstrap.sh
    ./b2 headers
}

build_config(){
    #./bootstrap.sh --with-toolset=clang
    #./b2 toolset=clang cxxflags="-stdlib=libc++" threading=multi threadapi=pthread link=shared runtime-link=shared -j 6
}

start