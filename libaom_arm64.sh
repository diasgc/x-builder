#!/bin/bash

libname=libaom
archname=arm64v8


# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

export LIBDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export BUILD_DIR=$(pwd)/${libname}_${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

while [ "$1" != "" ]; do
    case $1 in
        --clean )	rm -rf ${libname}/CMakeCache.txt ${libname}/CMakeFiles ${SRCDIR}
			exit 
                        ;;
	--clearall )    rm -rf ${libname} ${BUILD_DIR}
			exit
			;;
	--opts )	show_cmakeopts ${libname}
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

logstart ${libname}

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://aomedia.googlesource.com/aom ${libname}
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir -p ${BUILD_DIR}

cd ${BUILD_DIR}

log cmake
logthis ${CMAKE_EXECUTABLE} ../${libname} \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_SYSTEM_NAME=Android \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DANDROID_PLATFORM=${API} \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DARCH_ARM=1 \
 -DCONFIG_RUNTIME_CPU_DETECT=0 \
 -DCONFIG_PIC=1 \
 -DENABLE_TESTS=0 \
 -DENABLE_EXAMPLES=OFF \
 -DENABLE_DOCS=OFF

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend