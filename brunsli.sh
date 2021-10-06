#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++  ++  ++  ++  clang
# GNU ++   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='brunsli'
pkg='brunslienc-c'
dsc='Practical JPEG Repacker'
lic='MIT'
src='https://github.com/google/brunsli.git'
cfg='cmake'
eta='30'

lst_inc='brunsli/jpeg_data_writer.h
	brunsli/status.h
	brunsli/brunsli_encode.h
	brunsli/types.h
	brunsli/decode.h
	brunsli/brunsli_decode.h
	brunsli/jpeg_data.h
	brunsli/jpeg_data_reader.h
	brunsli/encode.h'
lst_lib='libbrunslidec-c libbrunslienc-c'
lst_bin=''

req_pcforlibs=$lst_lib

. xbuilder.sh

source_patch(){
    pushdir $SRCDIR
    
    # clone submodules
    git submodule update --init
    
    # patch to build both static and shared
    sed -i 's/target_link_libraries(brunslidec-c PRIVATE brunslidec-static)/set_target_properties(brunslidec-c brunslidec-static PROPERTIES OUTPUT_NAME brunslidec-c)\ntarget_link_libraries(brunslidec-c PRIVATE brunslidec-static)/' brunsli.cmake
    sed -i 's/target_link_libraries(brunslienc-c PRIVATE brunslienc-static)/set_target_properties(brunslienc-c brunslienc-static PROPERTIES OUTPUT_NAME brunslienc-c)\ntarget_link_libraries(brunslienc-c PRIVATE brunslienc-static)/' brunsli.cmake
    sed -i 's/TARGETS brunslidec-c brunslienc-c/TARGETS brunslidec-c brunslienc-c brunslidec-c brunslienc-static brunslidec-static/' brunsli.cmake

    popdir
}

build_pkgconfig_file(){
    create_pkgconfig_file 'brunslidec-c' '-lbrunslidec-c'
    create_pkgconfig_file 'brunslienc-c' '-lbrunslienc-c'
}

start

# TODO -------------------------------------
#  - missing 1 pc file (*dec) in package
#  - no bin (?)
#  - strip


# Filelist
# --------
# include/brunsli/jpeg_data_writer.h
# include/brunsli/status.h
# include/brunsli/brunsli_encode.h
# include/brunsli/types.h
# include/brunsli/decode.h
# include/brunsli/brunsli_decode.h
# include/brunsli/jpeg_data.h
# include/brunsli/jpeg_data_reader.h
# include/brunsli/encode.h
# lib/libbrunslidec-c.so
# lib/pkgconfig/brunslienc-c.pc
# lib/libbrunslienc-c.so
# lib/libbrunslidec-c.a
# lib/libbrunslienc-c.a
