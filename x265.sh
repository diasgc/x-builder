#!/bin/bash
# HINFO-----------------------------------
lib='x265'
dsc='x265 is an open source HEVC encoder'
lic='GPL-2.0'
#src='http://ftp.videolan.org/pub/videolan/x265/x265_3.2.tar.gz'
#sty='tgz'
src='https://github.com/videolan/x265.git'
sty='git'
cfg='cm'
tls='yasm libnuma-dev'
dep=''
eta='720'
pkg='x265'
# -----------------------------------------

OPT_HDR=
CFG=
CSH="-DENABLE_SHARED=OFF"
CBN=
FSH='g++/g++ -static -static-libgcc -static-libstdc++'
FLS='-Wl,-Bdynamic'

# required extraopts
extraOpts(){
  case $1 in
    --hdr10 ) OPT_HDR=1;;
    --hbit ) CFG="$CFG -DHIGH_BIT_DEPTH=ON";;
    --multilib ) OPT_HBD=1 && eta='1560';;
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

dbld=$(pwd)/sources/$lib/build_${arch}
if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="-DENABLE_SHARED=ON"
  [[ $bshared -eq 0 ]] && CSH="-DENABLE_SHARED=OFF"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="-DENABLE_CLI=ON"
  [[ $bbin -eq 0 ]] && CBN="-DENABLE_CLI=OFF"
fi

case $arch in
  aarch64-*-android|arm-*-androideabi ) setNDKToolchain
    CFG="-DCROSS_COMPILE_ARM=ON -DENABLE_ASSEMBLY=OFF $CFG"
    ;;&
  *-android|*-androideabi ) setNDKToolchain
    CFG="-DANDROID_ABI=$ABI -DANDROID_PLATFORM=$API \
	  -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake $CFG"
	FSH='-Wl,-Bsymbolic,-znoexecstack -shared/-static'
	FLS='-Wl,-Bsymbolic'
	# NDK Patch: create missing libpthread in NDK and replace march opt on HDR10
	lpthread="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$TARGET/libpthread.a"
	[ ! -f $lpthread ] && $AR cr $lpthread
    ;;
  *-linux-gnu ) setGnuToolchain
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="-DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_RC_COMPILER=${arch}-windres \
	-DCMAKE_CMAKE_RANLIB=${arch}-ranlib $CMAKE_ROOTPATH_OPTS -DENABLE_LUMA=OFF $CFG"
    ;;
esac

AS=$YASM
CFG="-DCMAKE_SYSTEM_NAME=$PLATFORM $CFG"

patchSrc(){
	sed -i 's|set(ARM_ARGS -march=armv6 -mfloat-abi=soft -mfpu=vfp -marm -fPIC)|set(ARM_ARGS -march=armv8-a -fPIC)|' $SRCDIR/source/dynamicHDR10/CMakeLists.txt
}

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
	log patch
	logme patchSrc
}

build12bit(){
	[ -z "$retry" ] && [ -d 12bit ] && rm -rf 12bit
	[ -d 12bit ] || mkdir -p 12bit
	cd 12bit
	log 12bit
	logme ${CMAKE_EXECUTABLE} $SRCDIR/source $CFG \
		-DHIGH_BIT_DEPTH=ON -DMAIN12=ON \
		-DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF
	#ccmake $SRCDIR/source
	log make
	logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}
	# logme ninja
	cd ..
}

build10bit(){
	[ -z "$retry" ] && [ -d 10bit ] && rm -rf 10bit
	[ -d 10bit ] || mkdir -p 10bit
	cd 10bit
	log 10bit
	logme ${CMAKE_EXECUTABLE} $SRCDIR/source $CFG \
		-DHIGH_BIT_DEPTH=ON \
		-DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF 
	log make
	logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}
	# logme ninja
	cd ..
}

makeStatic(){
	# static x265 x86_64 hack see https://gist.github.com/ttsuki/600b259879b7a7605747998fa723cf21 must NOT use ninja
	sed -i 's/'${FSH}'/g' $dbld/CMakeFiles/x265-shared.dir/link.txt
	sed -i 's/'${FSH}'/g' $dbld/CMakeFiles/cli.dir/link.txt
	[ -f "$(pwd)/CMakeFiles/x265-shared.dir/linklibs.rsp" ] && sed -i 's/'${FLS}'//' $dbld/CMakeFiles/x265-shared.dir/linklibs.rsp
	[ -f "$(pwd)/CMakeFiles/cli.dir/linklibs.rsp" ] && sed -i 's/'${FLS}'//' $dbld/CMakeFiles/x265-shared.dir/linklibs.rsp
	make -j${HOST_NPROC}
}

buildMultilib(){
	build12bit
	build10bit
	[ -d 8bit ] && rm -rf 8bit
	mkdir -p 8bit && cd 8bit
	ln -sf ../12bit/libx265.a libx265_main12.a
	ln -sf ../10bit/libx265.a libx265_main10.a
	log 8bit
	logme ${CMAKE_EXECUTABLE} $SRCDIR/source $CFG \
		-DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
		-DEXTRA_LIB="x265_main10.a;x265_main12.a" -DEXTRA_LINK_FLAGS=-L. \
		-DLINKED_10BIT=ON -DLINKED_12BIT=ON $CSH
	log make
	logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} x265-static
	mv libx265.a libx265_main.a
	$AR -M <<-EOF
			CREATE libx265.a
			ADDLIB libx265_main.a
			ADDLIB libx265_main10.a
			ADDLIB libx265_main12.a
			SAVE
			END
			EOF

	logme makeStatic

	log install
	# logme ${MAKE_EXECUTABLE} install/strip
	logme make install/strip
	cd ..
}

# Required function buildLib
buildLib(){
  if [ -z "$OPT_HBD" ];then
    log cmake
    logme ${CMAKE_EXECUTABLE} $SRCDIR/source -Wno-dev -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
			-DCMAKE_BUILD_TYPE=Release $CFG $CSH $CBN 

	# allow advanced config with ccmake if --advanced option selected
	[ $advcfg ] && inlineCcmake $SRCDIR/source

	local cmflags="-j${HOST_NPROC}"
	# force static makefile
	[ "$bshared" != "1" ] && cmflags="x265-static $cmflags"
    log make
    logme ${MAKE_EXECUTABLE} $cmflags

	# force static makefile
	[ "$bshared" != "1" ] && logme makeStatic

    log install
    logme ${MAKE_EXECUTABLE} install/strip
  else
    buildMultilib
  fi
}

start