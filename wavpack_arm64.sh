#!/bin/bash

libname=wavpack
archname=arm64v8
eta=172

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. tcutils.sh arm64 29

export LIBSDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export BUILDDIR=$SRCDIR
export INSTALL_DIR=$LIBSDIR/${libname}
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED="--disable-shared"
OPT_BIN="--disable-apps"

while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR && exit;;
	--clearall )    rm -rf ${libname} && exit;;
	--opts )	show_cmakeopts ${libname} && exit;;
	--shared )	OPT_SHARED="--enable-shared";;
	--bin )		OPT_BIN="--enable-apps";;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit
    esac
    shift
done

[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

chkTools automake autoconf autogen libtool m4
chkDeps libiconv

logstart ${libname}

if [ ! -d $SRCDIR ];then
	gitClone https://github.com/dbry/WavPack.git ${libname}
	cd $SRCDIR
	log autoreconf
	logme autoreconf -fi
	cd ..
fi

pushd $BUILDDIR >/dev/null

log configure
logme ./configure \
    --prefix=$INSTALL_DIR \
    --host=$TARGET \
    --with-sysroot=$SYSROOT \
    --with-pic \
    --enable-static \
    --disable-asm \
    --disable-dsd \
    --enable-legacy \
    --disable-tests \
    --enable-rpath \
    $OPT_SHARED $OPT_BIN
    

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/${libname}.pc
logend