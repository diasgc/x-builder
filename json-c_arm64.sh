#!/bin/bash
libname=json-c
archname=arm64v8
export INSTALL_DIR=$(pwd)/${archname}/${libname}
export PATH="$(pwd)/${archname}":$PATH

while [ "$1" != "" ]; do
    case $1 in
        --clean )	cd ${libname} && make clean
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

if [ ! -d "$(pwd)/${libname}" ];then
	git clone https://github.com/json-c/json-c.git || exit 1
fi

# enable ndk toolchain for arm64
. $(pwd)/tc_arm64v8.sh


if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir ${INSTALL_DIR}
pushd ${libname}

${CMAKE_EXECUTABLE} . \
 -DCMAKE_BUILD_TYPE=Release \
 -DBUILD_TESTING=OFF \
 -DCMAKE_C_COMPILER=${FAM_CC} \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}

${MAKE_EXECUTABLE} -j${HOST_NPROC}
${MAKE_EXECUTABLE} install