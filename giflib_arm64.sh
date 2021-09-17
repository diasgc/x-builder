#!/bin/bash

libname=giflib
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
	logthis git clone https://git.code.sf.net/p/giflib/code ${libname]
	cd ${libname}
	log patch
	sed -i 's/PREFIX = \/usr\/local/PREFIX = ${INSTALL_DIR}/g' Makefile
	sed -i 's/CFLAGS  = -std=gnu99 -fPIC -Wall -Wno-format-truncation $(OFLAGS)/CFLAGS  = -std=gnu99 -fPIC -fPIE -Wall $(OFLAGS)/g' Makefile
	sed -i 's/$(MAKE) -C doc/# $(MAKE) -C doc/g' Makefile
	sed -i 's/install: all install-bin install-include install-lib install-man/install: all install-bin install-include install-lib/g' Makefile
	cd ..
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

export PREFIX=${INSTALL_DIR}

log clean
${MAKE_EXECUTABLE} clean
log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend