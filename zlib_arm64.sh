#!/bin/bash

libname=zlib
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

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

if [ ! -d "$(pwd)/${libname}" ];then
	log "download "
	wget -O- https://zlib.net/zlib-1.2.11.tar.gz 2> /dev/null | tar xz
	mv ${libname}-* ${libname}
	echo -ne " ok "
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

log cmake
logthis ${CMAKE_EXECUTABLE} . -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
mv ${INSTALL_DIR}/share/pkgconfig ${INSTALL_DIR}/lib
cd ..

logend