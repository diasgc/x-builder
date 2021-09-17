#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='flac'
dsc='Free Lossless Audio Codec'
lic='BSD'
src='https://github.com/xiph/flac.git'
sty='git'
cfg='ag'
tls=''
dep='ogg libiconv'
pkg='flac'

eta='60'
lsz=
psz=(3132)
ets=(19 0 0 0 19 0 0 0 0 0 0)
ls0=(2664 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--disable-shared"
cs1="--enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
loadToolchain

case $cfg in
  cm) dbld=$SRCDIR/build_${arch}
      if [[ $arch == *"-android"* ]];then
        CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake \
          -DBUILD_CXXLIBS=ON -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF \
          -DINSTALL_MANPAGES=OFF -DWITH_ASM=ON -DWITH_OGG=ON -DOGG_INCLUDE_DIR=$LIBSDIR/include \
          -DOGG_LIBRARY=$LIBSDIR/lib/libogg.a -DIconv_LIBRARY=$LIBSDIR/lib/libiconv.a \
          -DIconv_INCLUDE_DIR=$LIBSDIR/include"
          export PKG_CONFIG_PATH=$LIBSDIR/lib/pkgconfig
      else
        CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake \
          -DBUILD_CXXLIBS=ON -DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF \
          -DINSTALL_MANPAGES=OFF -DWITH_ASM=ON -DWITH_OGG=ON -DOGG_INCLUDE_DIR=$LIBSDIR/ogg/include \
          -DOGG_LIBRARY=$LIBSDIR/ogg/lib/libogg.a -DIconv_LIBRARY=$LIBSDIR/libiconv/lib/libiconv.a \
          -DIconv_INCLUDE_DIR=$LIBSDIR/libiconv/include"
        [[ $arch == *"mingw32" ]] && export LD=$CC AS=nasm
      fi
      [[ "$CSH" = "$cs0" ]] && CSH="-DBUILD_SHARED_LIBS=OFF" || CSH="-DBUILD_SHARED_LIBS=ON"
      [[ "$CBN" = "$cb0" ]] && CBN="-DBUILD_PROGRAMS=OFF" || CBN="-DBUILD_PROGRAMS=ON"
      ;;
  ac|ag|ar) dbld=$SRCDIR
      test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG --with-pic"
      [[ $arch == "a"* ]] && CFG="$CFG --disable-asm-optimizations --disable-vsx --disable-avx --disable-sse --disable-altivec"
      ;;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start