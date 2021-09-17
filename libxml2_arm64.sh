#!/bin/bash

libname=libxml2
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
	--opts )	show_autoconfopts ${libname}
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

check_autotools

logstart ${libname}

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://gitlab.gnome.org/GNOME/libxml2.git
	cd ${libname}
	log autoreconf
	logthis autoreconf -f -i
	cd ..
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

log configure
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT} \
    --with-pic=1

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend