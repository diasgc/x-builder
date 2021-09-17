#!/bin/bash

libname=libraw
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

export LIBSDIR=$(pwd)/${archname}
export INSTALL_DIR=${LIBSDIR}/${libname}
export PATH="$(pwd)/${archname}":$PATH


# dependencies pkg-config autoconf automake

check_autotools

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/LibRaw/LibRaw.git libraw
	cd ${libname}
	log autoreconf
	logthis autoreconf -f -i || exit 1
	cd ..
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

export LDFLAGS="-L${LIBSDIR}/zlib/lib -L${LIBSDIR}/libjpeg/lib"
export CPPFLAGS="-I${LIBSDIR}/zlib/include -I${LIBSDIR}/libjpeg/include"
log configure
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-pic=1 \
    --disable-jasper \
    --disable-lcms \
    --disable-examples

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend