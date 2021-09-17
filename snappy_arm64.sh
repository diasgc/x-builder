#!/bin/bash

libname=snappy
archname=arm64v8
eta=54

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. tcutils.sh arm64 29

export LIBSDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export BUILDDIR=$SRCDIR
export INSTALL_DIR=$LIBSDIR/${libname}
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED=OFF
OPT_CCMAKE=
while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR && exit;;
	--clearall )    rm -rf ${libname} && exit;;
	--opts )	show_cmakeopts ${libname} && exit;;
	--ccmake )	OPT_CCMAKE=1;;
	--shared)	OPT_SHARED=ON;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit
    esac
    shift
done

[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

# chkTools tools...
# chkDeps libs...

logstart ${libname}

if [ ! -d $SRCDIR ];then
	gitClone https://github.com/google/snappy.git ${libname}
fi

pushd $BUILDDIR >/dev/null

export CMAKE_OPTS="-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCROSS_COMPILE_ARM=ON \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_SYSTEM_NAME=Android \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DANDROID_PLATFORM=${API} \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake"

if [ -z $OPT_CCMAKE ];then
	log cmake
	logme ${CMAKE_EXECUTABLE} . $CMAKE_OPTS -DBUILD_SHARED_LIBS=$OPT_SHARED -DSNAPPY_BUILD_TESTS=OFF
else
	ccmake . $CMAKE_OPTS
fi

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logme ${MAKE_EXECUTABLE} install

createPkgConfig(){
cat <<EOF >>$PKGDIR/${libname}.pc
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

log pkgconfig
logme createPkgConfig

popd >/dev/null
logver $PKGDIR/${libname}.pc
logend