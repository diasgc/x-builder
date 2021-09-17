#!/bin/bash
# test-ok: linux64 win64
# test-fail: android
# HEADER-----------------------------------
lib='svtav1'
dsc='SVT (Scalable Video Technology) for AV1 encoder/decoder library'
lic='BSD'
src='https://github.com/OpenVisualCloud/SVT-AV1.git'
sty='git'
bty='cm'
tls=''
dep=''
eta=''
pkg='SvtAv1Enc'

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_ENC=OFF -DBUILD_DEC=OFF"
cb1="-DBUILD_ENC=ON -DBUILD_DEC=ON"
# -----------------------------------------

CFG="-DBUILD_TESTING=OFF"
CSH=$cs0
CBN=$cb1

# required extraopts
extraOpts(){
  case $1 in
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided line 
dbld=$(pwd)/sources/$lib/build_${arch}
if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH=$cs1
  [[ $bshared -eq 0 ]] && CSH=$cs0
fi

# HEADER-----------------------------------
# CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
case $arch in
	*-android|*-androideabi ) setNDKToolchain
    CFG="-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	  -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API -DM_LIB=$SYSROOT/usr/lib/$arch/libm.a $CFG"
    ;;&
  *-w64-mingw32 ) setMinGWToolchain
    CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_RC_COMPILER=${arch}-windres -DCMAKE_CMAKE_RANLIB=${arch}-ranlib \
    $CMAKE_ROOTPATH_OPTS $CFG"
    ;;&
  *-linux-gnu ) setGnuToolchain
    ;;&
  aarch64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=aarch64 $CFG";;
	arm-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=armv7a $CFG";;
	i686-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=x86 $CFG";;
	x86_64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=x86_64 $CFG";;
esac

# Required function buildSrc
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
}

start