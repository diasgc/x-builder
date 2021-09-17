#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86 (static/shared)
#  ++  .   .   .   +-  .   ++  .
#
# HEADER-----------------------------------
lib='libheif'
dsc='HEIF and AVIF file format decoder and encoder'
lic='LGPL-3.0'
src='https://github.com/strukturag/libheif.git'
sty='git'
cfg='ac'
tls=''
dep='aom x265 libde265 libjpeg libpng'
pkg='libheif'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-shared"
cb0="--disable-examples"
cb1="--enable-examples"
# defaults
CSH=$cs0
CBN=$cb1
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="--disable-go --with-pic=1"
dbld=$SRCDIR
# END--------------------------------------

if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0="-DWITH_EXAMPLES=OFF"
  cb1="-DWITH_EXAMPLES=ON"
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  export LIBS="-lpng16"
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
else
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# debug: echo "$cfg : $CFG $CSH $CBN $"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    test $cfg = 'ac' && doAutogen $SRCDIR
}

# Use function beforeBuild to execute extra code before buildLib
beforeBuild(){
  case $arch in
    *linux*) export CPPFLAGS="-I$LIBSDIR/libjpeg/include"
      if [ -f $LIBSDIR/libnuma/lib/pkgconfig/libnuma.pc ];then
        cp $LIBSDIR/libnuma/lib/pkgconfig/libnuma.pc $PKGDIR
        CPPFLAGS="$CPPFLAGS -I$LIBSDIR/libnuma/include"
        export LIBS="-lnuma -ldl -lz $LIBS"
      fi
      setPkgConfigDir $PKGDIR
      ;;&
    *android*) export LDFLAGS="-Wl,-rpath,$SYSROOT/usr/lib/$arch/30 $LDFLAGS";;&
    *mingw32) CXX="$CXX-posix" && CC="$CC-posix";;
  esac
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start