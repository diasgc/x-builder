#!/bin/bash

libname=x265
archname=arm64v8
eta=111

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. tcutils.sh arm64 29

export LIBSDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export BUILDDIR=$SRCDIR/source
export INSTALL_DIR=$LIBSDIR/${libname}
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED=OFF
OPT_BIN=OFF
OPT_ADV=
OPT_HBD=

while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR && exit;;
	--clearall )    rm -rf ${libname} && exit;;
	--opts )	show_cmakeopts ${libname} && exit;;
	--shared )	OPT_SHARED=ON;;
	--bin )		OPT_BIN=ON;;
	--hdr10 )	OPT_ADV="-DENABLE_HDR10_PLUS=ON ${OPT_ADV}";;
	--highbitdep )	OPT_ADV="-DHIGH_BIT_DEPTH=ON ${OPT_ADV}";;
	--allbitdeps )	OPT_HBD=1;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit;;
    esac
    shift
done



[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

logstart ${libname}

patchSrc(){
	lpthread="$SYSROOT/usr/lib/$TARGET/libpthread.a"
	[ ! -f ${lpthread} ] && $AR cr ${lpthread}
	sed -i 's/set(ARM_ARGS -march=armv6 -mfloat-abi=soft -mfpu=vfp -marm -fPIC)/set(ARM_ARGS -march=armv8-a -fPIC)/g' $BUILDDIR/dynamicHDR10/CMakeLists.txt
}

if [ ! -d $SRCDIR ];then
	gitClone https://github.com/videolan/x265.git ${libname}
	log patch
	# Patch: create missing libpthread in NDK and replace march opt on HDR10
	logme patchSrc
fi

pushd $BUILDDIR >/dev/null

export CMAKE_OPTS="-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
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
logver $PKGDIR/x265.pc
logend