#!/bin/bash
#
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  P   P   .   .   .   .   .   .   .   .   .  static
#  P   P   .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

lib='codec2'
apt='libcodec2-0.9'
dsc='A speech codec for 2400 bit/s and below'
vrs='1.0.0'
lic='LGPL-2.1'
src='https://github.com/drowe67/codec2.git'
sty='git'
cfg='cm'
eta='80'

. xbuilder.sh

build_patch_config(){
    # make codec2_native use arch-build-cc/cxx instead of arch-host-cc/cxx
    # otherwise cross-compile cannot generate codebook executables
    if [[ $arch != x86_64-linux-gnu ]];then
        sed -i "s|SHELL = /bin/sh|SHELL = /bin/sh\nCC = /usr/bin/gcc\nCXX = /usr/bin/g++\n|" $BUILD_DIR/src/CMakeFiles/codec2_native.dir/build.make
        # patch for mingw
        if [[ $arch = *mingw32 ]];then
            sed -i "s|include|# include|" $BUILD_DIR/cmake/GetDependencies.cmake
            sed -i "s|get_prerequisites|# get_prerequisites|" $BUILD_DIR/cmake/GetDependencies.cmake
        fi
    else
        # avoid error calling patchMakefile
        echo -ne "$C0"
    fi
}

start

# Filelist
# --------
# include/codec2/modem_stats.h
# include/codec2/codec2_cohpsk.h
# include/codec2/fsk.h
# include/codec2/codec2_fdmdv.h
# include/codec2/codec2_ofdm.h
# include/codec2/comp.h
# include/codec2/codec2_fifo.h
# include/codec2/version.h
# include/codec2/freedv_api.h
# include/codec2/codec2.h
# include/codec2/codec2_fm.h
# include/codec2/reliable_text.h
# lib/pkgconfig/codec2.pc
# lib/libcodec2.so
# lib/cmake/codec2/codec2-config.cmake
# lib/cmake/codec2/codec2-config-release.cmake
