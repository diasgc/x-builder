#!/bin/bash
# test-ok: win64 linux64 aarch64-android
# HEADER-----------------------------------
lib='libtiff'
dsc='TIFF Library and Utilities'
lic='GPL?'
src='https://gitlab.com/libtiff/libtiff.git'
sty='git'
cfg='cm'
tls=''
dep='libzstd liblzma libjbig libjpeg'
eta='150'
pkg='libtiff'
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
CFG="-DJBIG_INCLUDE_DIR=$LIBSDIR/libjbig/include \
-DJBIG_LIBRARY=$LIBSDIR/libjbig/lib/libjbig.a \
-DJPEG_INCLUDE_DIR=$LIBSDIR/libjpeg/include \
-DJPEG_LIBRARY_RELEASE=$LIBSDIR/libjpeg/lib/libjpeg.a \
-DZSTD_INCLUDE_DIR=$LIBSDIR/libzstd/include \
-DZSTD_LIBRARY=$LIBSDIR/libzstf/lib/libzstd.a \
-DLIBLZMA_INCLUDE_DIR=$LIBSDIR/liblzma/include \
-DLIBLZMA_LIBRARY_RELEASE=$LIBSDIR/liblzma/lib/liblzma.a"
#-DJPEG12_INCLUDE_DIR=$LIBSDIR/libjbig/include \
#-DJPEG12_LIBRARY=$LIBSDIR/libjpeg/lib/libturbojpeg.a \
#-DWEBP_INCLUDE_DIR=$LIBSDIR/webp/include \
#-DWEBP_LIBRARY=$LIBSDIR/webp/lib/libwebp.a \
CSH="-DBUILD_SHARED_LIBS=OFF"
CBN=
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DBUILD_SHARED_LIBS=ON"
  [[ $bshared -eq 0 ]] && CSH="-DBUILD_SHARED_LIBS=OFF"
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

  log cmake
  logme ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release $CFG $CSH $CBN
  
  # allow advanced config with ccmake if --advanced option selected
  [ $advcfg ] && inlineCcmake $SRCDIR

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install

  mv $PKGDIR/$lib-*.pc $PKGDIR/$lib.pc
}

start