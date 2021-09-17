#!/bin/bash
# test-fail: win64/mingw (avifdec.c:60:42: error: unknown conversion type character ‘z’ in format)
# test-ok: linux
# HEADER-----------------------------------
lib='libavif'
dsc='Library for encoding and decoding .avif files'
lic='BSD?'
src='https://github.com/AOMediaCodec/libavif.git'
sty='git'
cfg='cm'
tls=''
dep='aom libjpeg libpng zlib'
eta='30'
pkg='libavif'
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
CFG="-DAVIF_BUILD_EXAMPLES=OFF -DAVIF_BUILD_TESTS=OFF -DAVIF_CODEC_AOM=ON \
	-DAOM_INCLUDE_DIR=$LIBSDIR/aom/include -DAOM_LIBRARY=$LIBSDIR/aom/lib/libaom.a \
	-DPNG_PNG_INCLUDE_DIR=$LIBSDIR/libpng/include -DPNG_LIBRARY=$LIBSDIR/libpng/lib/libpng.a \
	-DJPEG_INCLUDE_DIR=$LIBSDIR/libjpeg/include -DJPEG_LIBRARY=$LIBSDIR/libjpeg/lib/libjpeg.a \
	-DZLIB_INCLUDE_DIR=$LIBSDIR/zlib/include -DZLIB_LIBRARY=$LIBSDIR/zlib/lib/libz.a"
CSH="-DBUILD_SHARED_LIBS=OFF"
CBN="-DAVIF_BUILD_APPS=ON"
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
  # patch: must rearrange the order of libraries in CMakeLists.txt
  sed -i 's|${ZLIB_LIBRARY} ${PNG_LIBRARY} ${JPEG_LIBRARY}|${PNG_LIBRARY} ${JPEG_LIBRARY} ${ZLIB_LIBRARY}|g' $SRCDIR/CMakeLists.txt
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