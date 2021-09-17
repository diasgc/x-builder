#!/bin/bash
# HEADER-----------------------------------
lib='cpu_features'
dsc='A cross platform C99 library to get cpu features at runtime'
lic='Apache-2.0'
src='https://github.com/google/cpu_features.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta=''
pkg='cpu_features'
upk=
# -----------------------------------------

# required extraopts
extraOpts(){
  case $1 in
    --pkgdl ) upk=$arch;;
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG=
CSH="-DBUILD_SHARED_LIBS=OFF -DCONFIG_PIC=ON"
CBN=
dbld=$SRCDIR/build_${arch}

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH=
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
    $CMAKE_ROOTPATH_OPTS -DWITH_STACK_PROTECTOR=OFF $CFG"
    ;;&
  *-linux-gnu ) setGnuToolchain
    ;;&
  aarch64-* ) CFG="-DCMAKE_SYSTEM_PROCESSOR=aarch64 $CFG";;
	arm-* )     CFG="-DCMAKE_SYSTEM_PROCESSOR=armv7a $CFG";;
	i686-* )    CFG="-DCMAKE_SYSTEM_PROCESSOR=x86 $CFG";;
	x86_64-* )  CFG="-DCMAKE_SYSTEM_PROCESSOR=x86_64 $CFG";;
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
  
  log pkgconfig
  logme createPkgConfig
}

createPkgConfig(){
  cat <<-EOF >>$PKGDIR/${lib}.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: cpufeatures
		Description: cpu features Android utility
		Version: 0.4.1
		Requires:
		Libs: -L\${libdir} -lcpufeatures
		Cflags: -I\${includedir}
		EOF
}

start