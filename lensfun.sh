#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   F   .   .   .   .   .  static
#  F   .   .   .   .   F   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# Issues:
#  . W64: /usr/include/glib-2.0/glib/gtypes.h static assertion failed
#  . Axx-shared:/ld: cannot find -lglib-2.0 
# PKGINFO-------------------------------------
lib='lensfun'
dsc='An open source database of photographic lenses and their characteristics'
lic='LGPL-3.0'
src='https://github.com/lensfun/lensfun.git'
sty='git'
cfg='cm'
tls='libglib2.0-dev'
dep='libpng zlib'
pkg='lensfun'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_STATIC=ON -DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_STATIC=OFF -DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_LENSTOOL=OFF"
cb1="-DBUILD_LENSTOOL=ON"
CSH=$cs0
CBN=$cb1
# -DBUILD_LENSTOOL requires libpng
# -----------------------------------------

# enable main toolchain util
CFG="-DBUILD_TESTS=OFF -DBUILD_DOC=OFF -DINSTALL_HELPER_SCRIPTS=OFF -DINSTALL_PYTHON_MODULE=OFF -DBUILD_AUXFUN=ON"
. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DGLIB2_BASE_DIR=$SOURCES/glib2 $CFG"

# Use function buildSrc to custom clone repo
buildSrc(){
    pushd $SOURCES >/dev/null
    doLog 'git' gitClone $src $lib
    [ -d "glib2" ] || doLog 'glib2' gitClone https://github.com/GNOME/glib.git glib2
    popd >/dev/null
}
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start