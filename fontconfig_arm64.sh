#!/bin/bash

libname=fontconfig
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
	--clearall ) 	rm -rf ${libname}
			exit
			;;
	--opts )	show_autoconfopts ${libname}
      			exit
			;;
	* )  		echo --clean|--clearall
		        exit 1
		        ;;
    esac
    shift
done


export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH

[ ! -f ${LIBDIR}/freetype/lib/libfreetype.a ] && ./freetype_arm64.sh
[ ! -f ${LIBDIR}/libexpat/lib/libexpat.a ] && ./expat_arm64.sh
[ ! -f ${LIBDIR}/libxml2/lib/libxml2.a ] && ./libxml2_arm64.sh
[ ! -f ${LIBDIR}/json-c/lib/libjson-c.a ] && ./jsonc_arm64.sh

logstart ${libname}

if [ ! -d "$(pwd)/${libname}" ];then
	echo -ne "\e[32m[tools:gperf" && sudo apt -qq install gperf -y >/dev/null 2>&1
	echo -ne "|gettext" && sudo apt -qq install gettext -y >/dev/null 2>&1
	echo -ne "|autopoint]\e[0m " && sudo apt -qq install autopoint -y >/dev/null 2>&1

	log clone
	logthis git clone https://gitlab.freedesktop.org/fontconfig/fontconfig.git
	cd ${libname}
	log autoconf
	logthis autoreconf -fi
	cd ..	
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

export FREETYPE_LIBS="-L${LIBDIR}/freetype/lib"
export FREETYPE_CFLAGS="-I${LIBDIR}/freetype/include/freetype2 -I${LIBDIR}/freetype/include/freetype2/freetype -I${LIBDIR}/freetype/include/freetype2/freetype/config"
export JSONC_LIBS="-L${LIBDIR}/json-c/lib"
export JSONC_CFLAGS="-I${LIBDIR}/json-c/include"
export EXPAT_LIBS="-L${LIBDIR}/libexpat/lib"
export EXPAT_CFLAGS="-I${LIBDIR}/libexpat/include"

log configure
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --with-arch=aarch64 \
    --with-sysroot=${SYSROOT} \
    --with-pic \
    --with-libiconv-prefix=${LIBDIR}/libiconv \
    --with-expat=${LIBDIR}/libexpat \
    --without-libintl-prefix \
    --enable-static \
    --disable-shared \
    --disable-fast-install \
    --disable-rpath \
    --disable-docs


log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ../..
logend