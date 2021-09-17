#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86 (static/shared)
#  +   .   .   .   .   .   +   .
#
# HEADER-----------------------------------
lib='libxml2'
vrs='1.16'
dsc='Character set conversion library '
lic='GPL'
src='https://gitlab.gnome.org/GNOME/libxml2.git'
sty='git'
cfg='cm'
tls=''
dep='liblzma'
pkg='libxml-2.0'
# STATS------------------------------------
eta='90'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0

# enable main toolchain util
. tcutils.sh

CFG="--with-pic=1 --with-lzma=$LIBSDIR/liblzma --without-python"
dbld=$SRCDIR

loadToolchain
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0="-DLIBXML2_WITH_PROGRAMS=OFF"
  cb1="-DLIBXML2_WITH_PROGRAMS=ON"
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
  CFG="$CFG -DLIBXML2_WITH_TESTS=OFF -DLIBLZMA_INCLUDE_DIR=$LIBSDIR/liblzma/include \
    -DLIBLZMA_LIBRARY_RELEASE=$LIBSDIR/liblzma/lib/liblzma.a"
    #-DZLIB_INCLUDE_DIR= -DZLIB_LIBRARY_RELEASE= \
    #-D_Python_LIBRARY_RELEASE= \
    #-DIconv_INCLUDE_DIR= -DIconv_LIBRARY=
else
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

patchSrc(){
  NOCONFIGURE=1 doAutogen $SRCDIR
}

start