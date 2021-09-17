#!/bin/bash

libname=vidstab
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

export LIBDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

OPT_BIN="--disable-cli"
OPT_SHARED=

while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR
			exit 
                        ;;
	--clearall )    rm -rf ${libname}
			exit
			;;
	--opts )	show_autoconfopts ${libname}
			exit
			;;
	--shared )	OPT_SHARED="--enable-shared"
			;;
	--bin )		OPT_BIN="--enable-cli"
			;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make automake autoconf autogen libtool gettext texinfo tar gzip git perl nettle guile p11-kit gperf\n\n\e[0m"
		        exit
    esac
    shift
done

# checkTools make cmake
# checkDependencies <none>

logstart ${libname}

if [ ! -d $SRCDIR ];then
	log clone
	logthis git clone https://github.com/georgmartius/vid.stab.git ${libname}
fi

[ -d "${INSTALL_DIR}" ] && rm -rf ${INSTALL_DIR}
mkdir ${INSTALL_DIR}

pushd $SRCDIR >/dev/null

# log clean
# ${MAKE_EXECUTABLE} clean >/dev/null 2>&1

log cmake
logthis ${CMAKE_EXECUTABLE} . \
        -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_SYSTEM_NAME=Android \
	-DCMAKE_SYSTEM_PROCESSOR=aarch64 \
	-DCMAKE_ANDROID_API=${API} \
	-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
	-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
	-DBUILD_SHARED_LIBS=OFF \
	-DUSE_OMP=OFF -DSSE2_FOUND=OFF -DSSE3_FOUND=OFF -DSSSE3_FOUND=OFF -DSSE4_1_FOUND=OFF

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend