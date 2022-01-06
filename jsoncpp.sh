#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='jsoncpp'
dsc='A C++ library for interacting with JSON.'
lic='MIT'
src='https://github.com/open-source-parsers/jsoncpp.git'
sty='git'
cfg='cm'
eta='60'
cb0='-DJSONCPP_WITH_EXAMPLE=OFF'
cb1='-DJSONCPP_WITH_EXAMPLE=ON'

. xbuilder.sh

# -DBUILD_OBJECT_LIBS -DBUILD_SHARED_LIBS -DBUILD_STATIC_LIBS -DBUILD_TESTING -DJSONCPP_WITH_EXAMPLE

CFG="-DBUILD_TESTING=OFF -DJSONCPP_WITH_TESTS=OFF"

start

# Filelist
# --------

# include/json/assertions.h
# include/json/allocator.h
# include/json/value.h
# include/json/json_features.h
# include/json/config.h
# include/json/writer.h
# include/json/reader.h
# include/json/json.h
# include/json/version.h
# include/json/forwards.h
# lib/pkgconfig/jsoncpp.pc
# lib/objects-Release/jsoncpp_object/json_reader.cpp.o
# lib/objects-Release/jsoncpp_object/json_writer.cpp.o
# lib/objects-Release/jsoncpp_object/json_value.cpp.o
# lib/cmake/jsoncpp/jsoncpp-targets.cmake
# lib/cmake/jsoncpp/jsoncpp-namespaced-targets.cmake
# lib/cmake/jsoncpp/jsoncppConfigVersion.cmake
# lib/cmake/jsoncpp/jsoncpp-targets-release.cmake
# lib/cmake/jsoncpp/jsoncppConfig.cmake
# lib/libjsoncpp.so
# lib/libjsoncpp.a
