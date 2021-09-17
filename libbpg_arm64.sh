#!/bin/bash

libname=libbpg
archname=arm64v8


# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

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
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH
export SRCDIR=$(pwd)/${libname}

logstart ${libname}

if [ ! -d $SRCDIR ];then
	log clone
	logthis git clone https://github.com/mirrorer/libbpg.git
	# patch Makefile
	mv $SRCDIR/Makefile $SRCDIR/Makefile.old
	cp libbpg_arm64.makefile $SRCDIR/Makefile
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd $SRCDIR

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
#log install
#logthis ${MAKE_EXECUTABLE} install
cd ..
logend