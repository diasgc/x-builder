#!/bin/bash

libname=fdk-aac
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
	--opts )	show_autoconfopts ${libname}
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

check_autotools

logstart ${libname}

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

if [ ! -d "$(pwd)/${libname}" ];then
	log download
	logthis git clone https://github.com/mstorsjo/fdk-aac.git
	#missing log.h hack for android
	if [ ! -d ${libname}/libSBRdec/include/log ];then
  		log patch
		pushd ${libname}/libSBRdec/include >/dev/null
		mkdir log
		printf "#pragma once\n#include <cstdint>\ninline int android_errorWriteLog(int, const char*) { return 0; };\ninline int android_errorWriteWithInfoLog(int tag, const char* subTag, int32_t uid, const char* data, uint32_t dataLen) { return 0; };" >> log.h
		popd >/dev/null
	fi
	log autogen
	logthis sh ${libname}/autogen.sh
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

log configure
logthis ./configure --prefix=${INSTALL_DIR} --host=${TARGET} --with-pic=1

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend