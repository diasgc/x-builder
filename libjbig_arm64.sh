#!/bin/bash

libname=libjbig
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

while [ "$1" != "" ]; do
    case $1 in
	--clearall )    rm -rf jbigkit
			exit
			;;
        * )             echo --clearall
                        exit 1
    esac
    shift
done

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

logstart ${libname}

export INSTALL_DIR=$(pwd)/${archname}/${libname}
export PATH="$(pwd)/${archname}":$PATH

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://www.cl.cam.ac.uk/~mgk25/git/jbigkit
	cd jbigkit/libjbig
	sed -i 's|CC = gcc|CC = '$CC'|g' Makefile
	sed -i 's|ar rc|'$AR' rc|g' Makefile
	sed -i 's|-ranlib|-'$RANLIB'|g' Makefile
	cd ../..
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}
mkdir ${INSTALL_DIR}/lib
mkdir ${INSTALL_DIR}/include

cd jbigkit/libjbig

log make
logthis ${MAKE_EXECUTABLE} libjbig.a libjbig85.a -j${HOST_NPROC}
log install
cp *.a ${INSTALL_DIR}/lib
cp *.h ${INSTALL_DIR}/include
cd ../..
logend