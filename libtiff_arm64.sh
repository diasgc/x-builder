#!/bin/bash

libname=libtiff
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

while [ "$1" != "" ]; do
    case $1 in
        --clean )	cd ${libname} && make distclean && cd ..
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


# download deps TODO
[ ! -f $LIBDIR/libjbig/lib/libjbig.a ] && ./libjbig_arm64.sh

cd ${archname}
[ ! -d libzstd ] && log libzstd && logthis dl_deb libzstd http://ftp.de.debian.org/debian/pool/main/libz/libzstd/libzstd-dev_1.4.4+dfsg-3_arm64.deb
[ ! -d liblzma ] && log liblzma && logthis dl_deb liblzma http://ftp.de.debian.org/debian/pool/main/x/xz-utils/liblzma-dev_5.2.4-1+b1_arm64.deb
cd ..

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://gitlab.com/libtiff/libtiff.git
	log autogen
	cd ${libname}
	logthis ./autogen.sh
	cd ..
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

log configure
logthis ./configure --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT} \
    --with-pic \
    --disable-fast-install \
    --disable-win32-io \
    --with-jpeg-include-dir=${LIBDIR}/libjpeg/include \
    --with-jpeg-lib-dir=${LIBDIR}/libjpeg/lib \
    --with-zstd-include-dir=${LIBDIR}/libzstd/include \
    --with-zstd-lib-dir=${LIBDIR}/libzstd/lib/aarch64-linux-gnu \
    --with-lzma-include-dir=${LIBDIR}/liblzma/include \
    --with-lzma-lib-dir=${LIBDIR}/liblzma/lib/aarch64-linux-gnu \
    --with-jbig-include-dir=${LIBDIR}/libjbig/include \
    --with-jbig-lib-dir=${LIBDIR}/libjbig/lib/ \
    --enable-static \
    --disable-shared
#   --disable-cxx \

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend