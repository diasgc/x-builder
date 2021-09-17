#!/bin/bash

libname=libavif
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
	--opts )	show_cmakeopts ${libname}
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=${LIBDIR}/${libname}
export PATH="$(pwd)/${archname}":$PATH
export PKGDIR=$INSTALL_DIR/pkgconfig
export PKG_CONFIG_PATH=$PKGDIR

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

checkDependencies aom libjpeg libpng zlib

logstart ${libname}

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/AOMediaCodec/libavif.git
fi

cd ${libname}

export LIBS="-lpng -ljpeg -lz"
log cmake
logthis ${CMAKE_EXECUTABLE} . \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_SYSTEM_NAME=Android \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DANDROID_PLATFORM=${API} \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
 -DBUILD_SHARED_LIBS=OFF \
 -DAVIF_BUILD_APPS=ON \
 -DAVIF_BUILD_EXAMPLES=OFF \
 -DAVIF_BUILD_TESTS=OFF \
 -DAVIF_CODEC_AOM=ON

# -DAOM_INCLUDE_DIR=$LIBDIR/libaom/include \
# -DAOM_LIBRARY=$LIBDIR/libaom/lib/libaom.a \
# -DPNG_LIBRARY=$LIBDIR/libpng/lib/libpng.a \
# -DPNG_PNG_INCLUDE_DIR=$LIBDIR/libpng/include \
# -DJPEG_LIBRARY=$LIBDIR/libjpeg/lib/libjpeg.a \
# -DJPEG_INCLUDE_DIR=$LIBDIR/libjpeg/include \
# -DZLIB_LIBRARY=$LIBDIR/zlib/lib/libz.a \
# -DZLIB_INCLUDE_DIR=$LIBDIR/zlib/include \

# EDIT must rearrange the order of libraries in CMakeFiles/avifenc.dir/link.txt and /avifdec.dir/link.txt to png > jpeg > zlib
# -DCMAKE_STATIC_LINKER_FLAGS="-lpng -ljpeg -lz" \ doesnt work

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend