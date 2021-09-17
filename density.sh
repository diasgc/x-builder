#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   .   .   .   .   .   .   .  static
#  +   +   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='density'
dsc='Small & portable byte-aligned LZ77 compression'
lic='BSD-3c'
vrs='0.14.2'
src="https://github.com/k0dai/density/archive/refs/tags/density-${vrs}.tar.gz"
sty='tgz'
#src='https://github.com/k0dai/density.git'
#sty='git'
cfg='mk'
eta='30'

. xbuilder.sh

source_get(){
    case $sty in
        git) doLog 'git' git clone --recursive $src $lib;;
        tgz) doLog 'get' wget_tar density;;
        *) doErr "WTF?? $sty";;
    esac
    # patch unsupported ndk clang march native
    sed -i 's/ -march=native//g' $SRCDIR/Makefile $SRCDIR/benchmark/Makefile
}

cp_install(){
    cp $SRCDIR/build/*.so $1/lib
    cp $SRCDIR/build/*.a $1/lib
    cp $SRCDIR/src/*.h $1/include
}

build_all(){
    doLog 'clean' $MAKE_EXECUTABLE clean
    doLog 'make' $MAKE_EXECUTABLE CC=$CC AR=$AR library
    doLog 'install' cp_install $INSTALL_DIR
    
    pkgconfig_url='https://github.com/k0dai/density'
    doLog 'gen.pc' create_pkgconfig_file 'density' '-ldensity'
    
    mkdir -p tmp/lib/pkgconfig tmp/include
    doLog 'gen.tar' cp_install $SRCDIR/tmp
    cp $PKGDIR/$pkg.pc $SRCDIR/tmp/lib/pkgconfig
    pushdir $SRCDIR/tmp
    build_packages_filelist
    local d=$(build_packages_getdistdir)
    logme tar -czvf "${d}.tar.gz" *
    popdir
    rm -rf ${d} $SRCDIR/tmp
}

start


# Filelist
# --------
# include/globals.h
# include/density_api.h
# lib/pkgconfig/density.pc
# lib/libdensity.a
# lib/libdensity.so
