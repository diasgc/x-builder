#!/bin/bash

libname=cpu_features
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

export LIBSDIR=$(pwd)/${archname}
export INSTALL_DIR=${LIBSDIR}/${libname}
export PATH="$(pwd)/${archname}":$PATH
export SRCDIR=$(pwd)/${libname}

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

while [ "$1" != "" ]; do
    case $1 in
        --clean )	rm -rf ${libname}/CMakeCache.txt ${libname}/CMakeFiles ${SRCDIR}
			exit 
                        ;;
	--clearall )    rm -rf ${libname}
			exit
			;;
	--opts )	show_cmakeopts ${libname}
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

logstart ${libname}

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi

if [ ! -d "$(pwd)/${libname}" ];then
	log git
	logthis git clone https://github.com/google/cpu_features.git
fi

cd ${libname}

log cmake
logthis ${CMAKE_EXECUTABLE} . \
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
log pkgconfig
mkdir -p ${INSTALL_DIR}/lib/pkg-config 
cat > "${INSTALL_DIR}/lib/pkg-config/cpu_features.pc" << EOF
prefix=${INSTALL_DIR}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: cpufeatures
Description: cpu features Android utility
Version: 1.${API}
Requires:
Libs: -L\${libdir} -lcpufeatures
Cflags: -I\${includedir}
EOF
logend