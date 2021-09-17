#!/bin/bash

libname=exiv2
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
	--opts )	show_cmakeopts ${libname}
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

export LIBSDIR=$(pwd)/${archname}
export INSTALL_DIR=${LIBSDIR}/${libname}
export PATH="$(pwd)/${archname}":$PATH

if [ ! -d $LIBSDIR/libexpat ];then
	./expat_arm64.sh || exit 1
fi

logstart ${libname}

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/Exiv2/exiv2.git
fi

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

cd ${libname}

log cmake
logthis ${CMAKE_EXECUTABLE} . \
 -DANDROID_PLATFORM=${ANDROID_PLATFORM} \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_TOOLCHAIN_FILE=../${libname}_android.cmake \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_CROSSCOMPILING=TRUE \
 -DBUILD_SHARED_LIBS=ON \
 -DEXIV2_ENABLE_DYNAMIC_RUNTIME=OFF \
 -DEXIV2_BUILD_SAMPLES=OFF \
 -DBUILD_TESTING=OFF \
 -DEXIV2_ENABLE_PRINTUCS2=OFF \
 -DEXPAT_INCLUDE_DIR=../${archname}/expat/include \
 -DEXPAT_LIBRARY=../${archname}/expat/lib \
 -DIconv_INCLUDE_DIR=$LIBSDIR/libiconv/include \
 -DIconv_LIBRARY=$LIBSDIR/libiconv/lib/libiconv.a \
 -DEXIV2_ENABLE_PNG=ON \
 -DEXIV2_ENABLE_XMP=OFF

log build
logthis ${CMAKE_EXECUTABLE} --build .
log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend