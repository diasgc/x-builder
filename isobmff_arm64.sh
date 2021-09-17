#!/bin/bash

libname=isobmff
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

while [ "$1" != "" ]; do
    case $1 in
        --clean )	cd ${libname} && make clean && cd ..
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

check_autotools

logstart ${libname}

export LIBSDIR=$(pwd)/${archname}
export INSTALL_DIR=${LIBSDIR}/${libname}
export PATH="$(pwd)/${archname}":$PATH


if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/MPEGGroup/isobmff.git
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

log cmake
logthis ${CMAKE_EXECUTABLE} . \
	-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
	-DCMAKE_AR=$AR \
	-DBUILD_SHARED=OFF

log libisoiff
logthis ${MAKE_EXECUTABLE} libisoiff -j${HOST_NPROC}
log isoiff_tool
logthis ${MAKE_EXECUTABLE} isoiff_tool -j${HOST_NPROC}
#log install
#logthis ${MAKE_EXECUTABLE} install
cd ..
logend