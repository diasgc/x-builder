#!/bin/bash
# HEADER-----------------------------------
lib='snappy'
dsc='Snappy is a compression/decompression library'
lic='Apache-2'
src='https://github.com/google/snappy.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='54'
pkg='snappy'

# -----------------------------------------

# required extraopts
extraOpts(){
  case $1 in
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG="-DSNAPPY_BUILD_TESTS=OFF"
CSH="-DBUILD_SHARED_LIBS=OFF"
CBN=
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DBUILD_SHARED_LIBS=ON"
  [[ $bshared -eq 0 ]] && CSH="-DBUILD_SHARED_LIBS=OFF"
fi
#if [[ $bbin ]];then
#  [[ $bbin -eq 1 ]] && CBN=
#  [[ $bbin -eq 0 ]] && CBN=
#fi

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	  -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API $CGF"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM  -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_RC_COMPILER=${arch}-windres -DCMAKE_CMAKE_RANLIB=${arch}-ranlib -DCMAKE_ASM_YASM_COMPILER=$YASM \
    $CMAKE_ROOTPATH_OPTS $CFG"
    ;;&
  *-linux-gnu ) setGnuToolchain
    ;;&
  aarch64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=aarch64 -DCROSS_COMPILE_ARM=ON $CFG";;
  arm-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=armv7a -DCROSS_COMPILE_ARM=ON $CFG";;
  i686-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=x86 -DSNAPPY_REQUIRE_AVX=ON -DSNAPPY_REQUIRE_AVX2=ON $CFG";;
  x86_64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=x86_64 -DSNAPPY_REQUIRE_AVX=ON -DSNAPPY_REQUIRE_AVX2=ON $CFG";;
esac

# Required function
buildSrc(){
  gitClone $src $lib
}

# Required function buildLib
buildLib(){
  log cmake
  logme ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release $CFG $CSH $CBN
  
  # allow advanced config with ccmake if --advanced option selected
  [ $advcfg ] && inlineCcmake $SRCDIR

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install

  log pkgconfig
  logme createPkgConfig
}

createPkgConfig(){
cat <<EOF >>$PKGDIR/$lib.pc
prefix=${INSTALL_DIR}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: Snappy
Description: Snappy is a compression/decompression library
Version: 1.1.8
Requires:
Libs: -L\${libdir} -lsnappy
Cflags: -I\${includedir}
EOF
}

start