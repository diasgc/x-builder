#!/bin/bash

# ------------------------------
# TODO: enable asm optimizations
# ------------------------------

libname=x264
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
	* )  		echo -e "\n\n\tx264 builder 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:\tautomake autoconf\tndk make pkg-config\n\n\e[0m"
		        exit
    esac
    shift
done

logstart ${libname}

if [ ! -d $SRCDIR ];then
	log clone
	logthis git clone https://code.videolan.org/videolan/x264.git
fi

[ -d "${INSTALL_DIR}" ] && rm -rf ${INSTALL_DIR}
mkdir ${INSTALL_DIR}

pushd $SRCDIR >/dev/null

log clean
${MAKE_EXECUTABLE} clean >/dev/null 2>&1

log cmake
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --sysroot=${SYSROOT} \
    --enable-pic \
    --disable-asm \
    --enable-static \
    $OPT_SHARED $OPT_BIB

#    --extra-asflags="-arch arm -fembed-bitcode" \
#    --extra-cflags="-arch aarch64 -fembed-bitcode" \
#    --extra-ldflags="-arch aarch64 -fembed-bitcode" \
    

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend