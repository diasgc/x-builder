#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   +   N   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libheif'
dsc='HEand AVIF file format decoder and encoder'
lic='LGPL-3.0'
src='https://github.com/strukturag/libheif.git'
sty='git'
cfg='ac'
tls=''
dep='aom x265 libpng libjpeg libde265'
pkg='libheif'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static"
cs1="--enable-shared"
cb0="--disable-examples"
cb1="--enable-examples"
CSH=
CBN=

# enable main toolchain util
. tcutils.sh

dbld=$SRCDIR
loadToolchain --posix
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0="-DWITH_EXAMPLES=OFF"
  cb1="-DWITH_EXAMPLES=ON"
  CSH=$cs0
  CBN=$cb1
  #setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DWITH_AOM=ON -DWITH_X265=ON \
  -DWITH_DAV1D=OFF -DWITH_LIBDE265=ON -DWITH_RAV1E=OFF \
  -DAOM_INCLUDE_DIR=$LIBSDIR/include -DAOM_LIBRARY=$LIBSDIR/lib/libaom.a \
  -DX265_INCLUDE_DIR=$LIBSDIR/include -DX265_LIBRARY=$LIBSDIR/lib/libx265.a \
  -DJPEG_LIBRARY=$LIBSDIR/lib/libjpeg.a -DJPEG_INCLUDE_DIR=$LIBSDIR/include"
else
  CFG="--disable-rav1e --disable-go --disable-gdk-pixbuf --with-pic=1"
  # disable libde265 in armv8 when building shared libs due to relocation errors
  #[[ $CSH = *enable-shared* ]] && CFG="$CFG --disable-libde265"
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# keep libs in this order
export CPPFLAGS="-I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" LIBS="-ljpeg -lpng16 -lz" PKG_CONFIG_PATH=$LIBSDIR/lib/pkgconfig
  
#CXXFLAGS="-flto -O3 -Wno-error $CXXFLAGS" CFLAGS="-flto -O3 -Wno-error $CFLAGS"


# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    test $cfg = 'ac' && doAutogen $SRCDIR
}

# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start