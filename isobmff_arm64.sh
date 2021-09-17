#!/bin/bash
libname=isobmff
archname=arm64v8
export INSTALL_DIR=$(pwd)/${archname}/${libname}
export PATH="$(pwd)/${archname}":$PATH

while [ "$1" != "" ]; do
    case $1 in
        --clean )	rm -rf ./${libname}/CmakeFiles
			rm CMakeCache.txt
			exit 
                        ;;
	--clearall )    rm -rf ./{libname}
			exit
			;;
        * )             echo usage isobmff_arm64 [--clean|--clearall]
                        exit 1
    esac
    shift
done
if [ ! -d "$(pwd)/${libname}" ];then
	git clone https://github.com/MPEGGroup/isobmff.git
fi

# enable ndk toolchain for arm64
. $(pwd)/tc_arm64v8.sh


if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}
pushd ${libname}

${CMAKE_EXECUTABLE} . \
 -DANDROID_PLATFORM=${ANDROID_PLATFORM} \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DCMAKE_TOOLCHAIN_FILE=../isobmff_android.cmake \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_CROSSCOMPILING=TRUE \
 -DCMAKE_INSTALL_SO_NO_EXE=0

${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install
