#!/bin/bash

lib='jsoncpp'
dsc='A C++ library for interacting with JSON.'
lic='MIT'
src='https://github.com/open-source-parsers/jsoncpp.git'
cfg='cmake'
eta='60'
cstk='BUILD_STATIC_LIBS'
cbk='JSONCPP_WITH_EXAMPLE'

lst_inc='json/*.h'
lst_lib='libjsoncpp.*'
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc='jsoncpp.pc'

. xbuilder.sh

# -DBUILD_OBJECT_LIBS -DBUILD_SHARED_LIBS -DBUILD_STATIC_LIBS -DBUILD_TESTING -DJSONCPP_WITH_EXAMPLE

CFG="-DBUILD_TESTING=OFF -DJSONCPP_WITH_TESTS=OFF"

start

# cpu av8 av7 x86 x64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc