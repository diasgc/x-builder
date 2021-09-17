#!/bin/bash
# HEADER-----------------------------------
lib='openjpeg'
dsc='OpenJPEG is an open-source JPEG 2000 codec written in C language'
lic='BSD 2-clause'
src='https://github.com/uclouvain/openjpeg.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='195'
pkg='libopenjp2'
# -----------------------------------------
buildFull=
# required extraopts
extraOpts(){
  case $1 in
    --full ) buildFull=1;;
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG=
[ $buildFull ] && CFG="-DBUILD_JPWL=OFF -DBUILD_JPIP=ON -DBUILD_JP3D=ON -DBUILD_JAVA=OFF \
      -DLCMS2_LIBRARY=$LIBSDIR/lcms2/lib/liblcms2.a -DLCMS2_INCLUDE_DIR=$LIBSDIR/lcms2/include \
      -DPNG_LIBRARY_RELEASE=$LIBSDIR/libpng/lib/libpng.a -DPNG_PNG_INCLUDE_DIR=$LIBSDIR/libpng/include \
      -DTIFF_LIBRARY_RELEASE=$LIBSDIR/libtiff/lib/libtiff.a -DTIFF_INCLUDE_DIR=$LIBSDIR/libtiff/include \
      -DZLIB_LIBRARY_RELEASE=$LIBSDIR/zlib/lib/libz.a -DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include" \
      dep='lcms2 libpng zlib libtiff'
CSH="-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON"
CBN=
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON"
  [[ $bshared -eq 0 ]] && CSH="-DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON"
fi

# HEADER-----------------------------------

case $arch in
	*-android|*-androideabi ) setNDKToolchain
    CFG="-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	  -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API $CFG"
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

  #${MAKE_EXECUTABLE} clean >/dev/null 2>&1
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
