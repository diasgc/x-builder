#!/bin/bash

libname=libjpeg
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

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
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

logstart ${libname}

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git ${libname}
fi

cd ${libname}

log cmake
logthis ${CMAKE_EXECUTABLE} . \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_SYSTEM_NAME=Linux \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_AR=${LLVM_AR} \
 -DENABLE_SHARED=OFF \
 -DWITH_JPEG8=ON \
 -DWITH_JPEG7=ON

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend