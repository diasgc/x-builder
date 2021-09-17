#!/bin/bash
#
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   +   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
#
# PKGINFO--------------------------------
lib='codec2'
dsc='A speech codec for 2400 bit/s and below'
lic='LGPL-2.1'
src='https://github.com/drowe67/codec2.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='codec2'

eta='80'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DINSTALL_EXAMPLES=OFF"
cb1="-DINSTALL_EXAMPLES=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------


. tcutils.sh
dbld=$SRCDIR/build_${arch}
CFG="-DUNITTEST=OFF"
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
patchMakefile(){
    # make codec2_native use build native cc
    if [[ $arch != x86_64-linux-gnu ]];then
        sed -i "s|SHELL = /bin/sh|SHELL = /bin/sh\nCC = /usr/bin/gcc\nCXX = /usr/bin/g++\n|" $dbld/src/CMakeFiles/codec2_native.dir/build.make
        # patch for mingw
        if [[ $arch = *mingw32 ]];then
            sed -i "s|include|# include|" $dbld/cmake/GetDependencies.cmake
            sed -i "s|get_prerequisites|# get_prerequisites|" $dbld/cmake/GetDependencies.cmake
        fi
    else
        # avoid error calling patchMakefile
        echo -ne "$C0"
    fi
}
# Use function buildPC to manually build pkg-config .pc file
start