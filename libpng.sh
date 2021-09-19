#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86 V1.6.38
#  +   +   +   +   .   +   +   +   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libpng'
dsc='Portable Network Graphics support'
lic='As Is'
src='https://git.code.sf.net/p/libpng/code'
sty='git'
cfg='cm'
#mki='install/strip'
#mkd=''
eta='9'
#cmake_path="lib/libpng"
cst0="-DPNG_STATIC=OFF" cst1="-DPNG_STATIC=ON"
csh0="-DPNG_SHARED=OFF" csh1="-DPNG_SHARED=ON"
cb0="-DPNG_EXECUTABLES=OFF"
cb1="-DPNG_EXECUTABLES=ON"

. xbuilder.sh

CFG="-DPNG_TESTS=OFF -DPNG_HARDWARE_OPTIMIZATIONS=OFF -DHAVE_LD_VERSION_SCRIPT=OFF"

case $arch in
#    *-mingw32) dep='zlib' CFG="${CFG} -DZLIB_INCLUDE_DIR=${LIBSDIR}/include -DZLIB_LIBRARY=${LIBSDIR}/lib/libzlib.dll.a";;
    a*-gnu*|*-mingw32) pushvar_l CFG "-DPNG_BUILD_ZLIB=ON"; pushvar_l dep "zlib";;
esac

start

# Filelist
# --------

# include/pnglibconf.h
# include/png.h
# include/libpng16/pnglibconf.h
# include/libpng16/png.h
# include/libpng16/pngconf.h
# include/pngconf.h
# lib/pkgconfig/libpng16.pc
# lib/libpng/libpng16-release.cmake
# lib/libpng/libpng16.cmake
# lib/libpng16.a
# lib/libpng16.so
# share/man/man5/png.5
# share/man/man3/libpng.3
# share/man/man3/libpngpf.3
# bin/png-fix-itxt
# bin/libpng16-config
# bin/pngfix
