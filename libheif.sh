#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   +   N   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libheif'
dsc='HEIF and AVIF file format decoder and encoder'
lic='LGPL-3.0'
src='https://github.com/strukturag/libheif.git'
sty='git'
cfg='ac'
tls=''
dep='aom x265 libde265 libjpeg libpng zlib'
pkg='libheif'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-shared --enable-static"
cb0="--disable-examples"
cb1="--enable-examples"
CSH=$cs0
CBN=$cb1

# enable main toolchain util
. tcutils.sh
CFG="--disable-go --disable-tests --disable-gdk-pixbuf --disable-libfuzzer --with-pic=1"
dbld=$SRCDIR
loadToolchain --posix
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0="-DWITH_EXAMPLES=OFF"
  cb1="-DWITH_EXAMPLES=ON"
  CSH=$cs0
  CBN=$cb1
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  LIBS="-lpng16"
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
else
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

export LDFLAGS="-static -L$LIBSDIR/libjpeg/lib -L$LIBSDIR/zlib/lib" \
  CPPFLAGS="-static -I$LIBSDIR/libjpeg/include -I$LIBSDIR/zlib/include" \
  CXXFLAGS="-static -Wno-error -static-libgcc -static-libstdc++" \
  CFLAGS="-static -Wno-error" \
  LIBS="-lz $LIBS"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    test $cfg = 'ac' && doAutogen $SRCDIR
}

# Use function beforeBuild to execute extra code before buildLib
beforeBuild(){
  setPkgConfigDir $PKGDIR zlib
  case $arch in
    *linux*) 
      if [ -f $LIBSDIR/libnuma/lib/pkgconfig/libnuma.pc ];then
        cp $LIBSDIR/libnuma/lib/pkgconfig/libnuma.pc $PKGDIR
      fi
      LDFLAGS="$LDFLAGS -Wl,-rpath,$LT_SYS_LIBRARY_PATH"
      CPPFLAGS="$CPPFLAGS -I$LIBSDIR/libnuma/include"
      LIBS="-lnuma -ldl $LIBS"
      ;;
  esac
  #export LDFLAGS CFLAGS CXXFLAGS CPPFLAGS LIBS
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start