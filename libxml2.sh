#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libxml2'
vrs='1.16'
dsc='Character set conversion library '
lic='GPL'
src='https://gitlab.gnome.org/GNOME/libxml2.git'
sty='git'
cfg='ac'
tls=''
dep='liblzma'
pkg='libxml-2.0'


eta='90'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG="--with-pic=1 --with-lzma=$LIBSDIR/liblzma --without-python"
dbld=$SRCDIR
loadToolchain
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0="-DLIBXML2_WITH_PROGRAMS=OFF"
  cb1="-DLIBXML2_WITH_PROGRAMS=ON"
  CSH=$cs0
  CBN=$cb1
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
  CFG="$CFG -DLIBXML2_WITH_TESTS=OFF -DLIBLZMA_INCLUDE_DIR=$LIBSDIR/include \
    -DLIBLZMA_LIBRARY_RELEASE=$LIBSDIR/lib/liblzma.a"
    #-DZLIB_INCLUDE_DIR= -DZLIB_LIBRARY_RELEASE= \
    #-D_Python_LIBRARY_RELEASE= \
    #-DIconv_INCLUDE_DIR= -DIconv_LIBRARY=
else
  [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  doAutogen $SRCDIR --noconfigure
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start