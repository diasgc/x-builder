#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='vvc'
dsc='VVC VTM reference software'
lic='LGPL-2.1'
src='https://vcgit.hhi.fraunhofer.de/jvet/VVCSoftware_VTM.git'
# https://github.com/OpenVVC/VVCSoftware_VTM.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='vvc'

eta='480'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_STATIC=ON -DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_STATIC=OFF -DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_TOOLS=OFF"
cb1="-DBUILD_TOOLS=ON"
CSH=$cs0
CBN=$cb0
mkinstall='all'
# -----------------------------------------

. tcutils.sh
CFG=
dbld=$SRCDIR/build_${arch}
loadToolchain
case $arch in
  *android*) CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DUSE_OPENCV_TOOLCHAIN_FLAGS=ON";;
  aarch64-linux-gnu ) CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/CMakeBuild/cmake/toolchains/$arch-gcc-posix-ubuntu1804.cmake";;
  i686-w64-mingw32 )  CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/CMakeBuild/cmake/toolchains/$arch-gcc-posix-ubuntu1604.cmake" MKF="$MKF toolset=gcc";;
  x86_64-w64-mingw32 )  CFG="-DCMAKE_TOOLCHAIN_FILE=$SRCDIR/cmake/CMakeBuild/cmake/toolchains/$arch-gcc-posix-ubuntu1604.cmake" MKF="all toolset=gcc";;
esac

  # *mingw32:
  # mind CMAKE_FIND_ROOT_PATH /usr/share/mingw-w64 /usr/x86_64-w64-mingw32 /usr/lib/gcc/x86_64-w64-mingw32/5.3-posix
  # todo: make static build as x265 to include libstdc++-6.dll libgcc_s_seh-1.dll

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  vmingw=$(getMinGwVersion)
  sed -i "s|5.3|$vmingw|g" $SRCDIR/cmake/CMakeBuild/cmake/toolchains/i686-w64-mingw32-gcc-posix-ubuntu1604.cmake
  sed -i "s|5.3|$vmingw|g" $SRCDIR/cmake/CMakeBuild/cmake/toolchains/x86_64-w64-mingw32-gcc-posix-ubuntu1604.cmake
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start
