#!/bin/bash
libname=libraw
archname=arm64v8
export INSTALL_DIR=$(pwd)/${archname}/${libname}
export PATH="$(pwd)/${archname}":$PATH

while [ "$1" != "" ]; do
    case $1 in
        --clean )	rm -rf ./${libname}/source/CmakeFiles
			rm ./${libname}/source/CMakeCache.txt
			exit 
                        ;;
	--clearall )    rm -rf ./{libname}
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

if [ ! -d "$(pwd)/${libname}" ];then
	git clone https://github.com/LibRaw/LibRaw.git libraw
fi

# enable ndk toolchain for arm64
. $(pwd)/tc_arm64v8.sh


if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}

pushd ${libname}
#export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
#export TARGET=aarch64-linux-android
#export API=24
#export AR=$TOOLCHAIN/bin/$TARGET-ar
#export AS=$TOOLCHAIN/bin/$TARGET-as
#export CC=$TOOLCHAIN/bin/$TARGET$API-clang
#export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
#export LD=$TOOLCHAIN/bin/$TARGET-ld
#export RANLIB=$TOOLCHAIN/bin/$TARGET-ranlib
#export STRIP=$TOOLCHAIN/bin/$TARGET-strip

autoreconf -f -i
./configure \
    --prefix=${INSTALL_DIR} \
    --host=${TARGET} \
    --with-sysroot=${SYSROOT_PATH} \
    --enable-jpeg \
    --enable-zlib \
    CC=${FAM_CC} \
    CXX=${FAM_CXX} \
    CPPFLAGS=-I${SYSROOT_PATH}/usr/include

${MAKE_EXECUTABLE} clean
${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install
