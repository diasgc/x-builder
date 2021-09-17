#!/bin/bash

libname=theora
archname=arm64v8
eta=391

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
OPT_BIN=

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
	--bin )		OPT_BIN=
			;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit
    esac
    shift
done



[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

chkTools make automake autoconf automake m4 libtool
chkDeps libogg vorbis

logstart ${libname}

if [ ! -d $SRCDIR ];then
	gitClone https://github.com/xiph/theora.git ${libname}
	cd $SRCDIR
	log autogen
	logme ./autogen.sh
	cd ..
fi

pushd $SRCDIR >/dev/null

log configure
logme ./configure \
    --prefix=$INSTALL_DIR \
    --host=$TARGET --with-sysroot=$SYSROOT \
    --with-pic --enable-static $OPT_SHARED \
    --disable-doc --disable-spec --disable-examples \
    --disable-oggtest --disable-vorbistest \
     $OPT_BIN

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/${libname}.pc
logend