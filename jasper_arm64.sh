#!/bin/bash

libname=jasper
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

export LIBSDIR=$(pwd)/${archname}
export INSTALL_DIR=${LIBSDIR}/${libname}
export BUILD_DIR=$(pwd)/${libname}_${archname}
export PATH="$(pwd)/${archname}":$PATH

while [ "$1" != "" ]; do
    case $1 in
        --clean )	rm -rf ${libname}/CMakeFiles ${libname}/CMakeCache.txt
			exit 
                        ;;
	--clearall )    rm -rf ${libname}
			exit
			;;
	--opts )	show_cmakepts ${libname}
			;;
	* )  		echo -e "\n\njasper builder 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:\t\tcmake/ndk make pkg-config\n\n\e[0m"
		        exit
		        ;;    esac
    shift
done

check_autotools

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}



logstart ${libname}

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/mdadams/jasper.git
fi

if [ -d "${BUILD_DIR}" ];then
	rm -rf ${BUILD_DIR}
fi
mkdir ${BUILD_DIR}
cd ${BUILD_DIR}

log cmake
logthis ${CMAKE_EXECUTABLE} ../${libname} \
	-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
	-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	-DCMAKE_SYSTEM_NAME=Android \
	-DCMAKE_ANDROID_ARCH=arm64-v8a \
	-DCMAKE_ANDROID_API=${API}

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend