#!/bin/bash

libname=opencore-amr
arch=arm64
eta=391

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. tcutils.sh $arch 29

export LIBSDIR=$(pwd)/${arch}
export SRCDIR=$(pwd)/${libname}
export BUILDDIR=$SRCDIR
export INSTALL_DIR=$LIBSDIR/${libname}
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED=OFF
OPT_BIN=

while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR && exit ;;
	--clearall )    rm -rf ${libname} && exit;;
	--opts )	show_autoconfopts ${libname} && exit;;
	--shared )	OPT_SHARED=ON;;
	--bin )		OPT_BIN=;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit
    esac
    shift
done



[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

# chkTools tools...
chkDeps libjpeg libpng libtiff libjasper
# chkDeps libtbb2 libtbb-dev libjpeg libpng libtiff libjasper libdc1394-22-dev

logstart ${libname}

if [ ! -d $SRCDIR ];then
	gitClone https://git.code.sf.net/p/opencore-amr/code ${libname}
	cd $SRCDIR
	logme autoreconf -fi
	cd ..
fi

pushd $SRCDIR >/dev/null

CMAKE_BASE="-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -DCROSS_COMPILE_ARM=ON -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_SYSTEM_NAME=Android -DANDROID_ABI=${ANDROID_ABI} -DANDROID_PLATFORM=${API}"
CMAKE_OPTS="-DBUILD_DOCS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=$OPT_SHARED"

log cmake
logme ${CMAKE_EXECUTABLE} . $CMAKE_BASE $CMAKE_OPTS

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$libname.pc
logend