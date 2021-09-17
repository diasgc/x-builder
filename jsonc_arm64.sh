#!/bin/bash

libname=json-c
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

while [ "$1" != "" ]; do
    case $1 in
        --clean )	cd ${libname} && make clean && cd ..
			exit 
                        ;;
	--clearall )    rm -rf ${libname}
			exit
			;;
	--opts )	show_cmakeopts
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

logstart ${libname}

export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/json-c/json-c.git
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

log cmake
logthis ${CMAKE_EXECUTABLE} . -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -DBUILD_TESTING=OFF
log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend