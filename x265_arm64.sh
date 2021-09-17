#!/bin/bash

lib='x265'
dsc='x265 is an open source HEVC encoder'
lic='GPL-2.0'
src='https://github.com/videolan/x265.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='111'

arch=arm64

LOGFILE=$(pwd)/${lib}_${arch}.log

# enable ndk toolchain for arm64
. tcutils.sh $arch 29

export LIBSDIR=$(pwd)/${arch}
export SRCDIR=$(pwd)/$lib
export BUILDDIR=$SRCDIR/source
export INSTALL_DIR=$LIBSDIR/$lib
export PKGDIR=$INSTALL_DIR/lib/pkgconfig


OPT_SHARED=OFF
OPT_BIN=OFF
OPT_ADV=
OPT_HBD=

while [ "$1" != "" ]; do
  case $1 in
    --clean )		cmakeClean $SRCDIR && exit;;
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_cmakeopts $lib && exit;;
	--shared )		OPT_SHARED=ON;;
	--bin )			OPT_BIN=ON;;
	--hdr10 )		OPT_ADV="-DENABLE_HDR10_PLUS=ON ${OPT_ADV}";;
	--highbitdep )	OPT_ADV="-DHIGH_BIT_DEPTH=ON ${OPT_ADV}";;
	--allbitdeps )	OPT_HBD=1;;
	--update )		update=1;;
	* )  			usage && exit;;
  esac
  shift
done

if [ -z "$update" ] && [ -f $PKGDIR/$lib.pc ] && [ -f $INSTALL_DIR/lib/$lib.a ]; then
	logstart $lib
	logver $PKGDIR/$lib.pc
	logend
	exit 0
fi
	
# Reset LOGFILE
[ -f $LOGFILE ] && rm -f $LOGFILE

# Reset INSTALL_DIR
[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR

# Create INSTALL_DIR and PKGCONFIG DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

# Check Tools and Dependencies
chkTools $tls
chkDeps $dep

logstart $lib

[ -n "$update" ] && rm -rf $SRCDIR

patchSrc(){
	lpthread="$SYSROOT/usr/lib/$TARGET/libpthread.a"
	[ ! -f ${lpthread} ] && $AR cr ${lpthread}
	sed -i 's/set(ARM_ARGS -march=armv6 -mfloat-abi=soft -mfpu=vfp -marm -fPIC)/set(ARM_ARGS -march=armv8-a -fPIC)/g' $BUILDDIR/dynamicHDR10/CMakeLists.txt
}

if [ ! -d $SRCDIR ];then
	gitClone $src $lib
	log patch
	# Patch: create missing libpthread in NDK and replace march opt on HDR10
	logme patchSrc
fi

pushd $BUILDDIR >/dev/null

CMAKE_OPTS="-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCROSS_COMPILE_ARM=ON \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_SYSTEM_NAME=Android \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DANDROID_PLATFORM=${API} \
 -DENABLE_ASSEMBLY=OFF \
 -DEXPORT_C_API=OFF \
 -DSTATIC_LINK_CRT=ON \
 -DENABLE_PIC=ON \
 -DENABLE_LIBNUMA=OFF \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake"

build12bit(){
	[ -d 12bit ] && rm -rf 12bit
	mkdir -p 12bit && cd 12bit
	log 12bit
	logme ${CMAKE_EXECUTABLE} ../ $CMAKE_OPTS -DHIGH_BIT_DEPTH=ON -DMAIN12=ON -DENABLE_SHARED=OFF -DENABLE_CLI=OFF
	log make
        logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}
	cd ..
}

build10bit(){
	[ -d 10bit ] && rm -rf 10bit
	mkdir -p 10bit && cd 10bit
	log 10bit
	logme ${CMAKE_EXECUTABLE} ../ $CMAKE_OPTS -DHIGH_BIT_DEPTH=ON -DENABLE_SHARED=OFF -DENABLE_CLI=OFF
	log make
        logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}
	cd ..
}

buildHighBit(){
	build12bit
	build10bit
	[ -d 8bit ] && rm -rf 8bit
	mkdir -p 8bit && cd 8bit
	ln -sf ../12bit/libx265.a libx265_main12.a
	ln -sf ../10bit/libx265.a libx265_main10.a	
	log 8bit
	logme ${CMAKE_EXECUTABLE} ../ $CMAKE_OPTS -DEXTRA_LIB="x265_main10.a;x265_main12.a" -DEXTRA_LINK_FLAGS=-L. -DLINKED_10BIT=ON -DLINKED_12BIT=ON -DENABLE_SHARED=OFF -DENABLE_CLI=OFF $OPT_ADV
	log make
        logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}
	mv libx265.a libx265_main.a
$AR -M <<EOF
CREATE libx265.a
ADDLIB libx265_main.a
ADDLIB libx265_main10.a
ADDLIB libx265_main12.a
SAVE
END
EOF
	log install
	logme ${MAKE_EXECUTABLE} install
	cd ..
}

if [ -z $OPT_HBD ];then
	log cmake
	logme ${CMAKE_EXECUTABLE} . $CMAKE_OPTS -DENABLE_SHARED=$OPT_SHARED -DENABLE_CLI=$OPT_BIN $OPT_ADV
	log make
	logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}
	log install
	logme ${MAKE_EXECUTABLE} install
else
	buildHighBit
fi

popd >/dev/null
logver $PKGDIR/$lib.pc
logend