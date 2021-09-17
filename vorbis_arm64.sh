#!/bin/bash

libname=vorbis
archname=arm64v8
eta=169

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

export LIBDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export INSTALL_DIR=$LIBDIR/${libname}

OPT_SHARED="--disable-shared"

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
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared]\e[90m\n\n\tTools:make automake autoconf libtool m4\n\n\e[0m"
		        exit
    esac
    shift
done

export PKGDIR=$INSTALL_DIR/lib/pkgconfig

[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

checkTools make automake autoconf libtool m4
checkDependencies $LIBDIR $PKGDIR libogg

logstart ${libname}

if [ ! -d $SRCDIR ];then
	log clone
	logthis git clone https://github.com/xiph/vorbis.git
	log autogen
	cd $SRCDIR
	logthis ./autogen.sh
	cd ..
fi

pushd $SRCDIR >/dev/null

#log 'clean '
#${MAKE_EXECUTABLE} clean >/dev/null 2>&1

log configure
logthis ./configure \
    --prefix=$INSTALL_DIR \
    --host=aarch64-linux-android \
    --with-sysroot=$SYSROOT \
    --with-pic \
    --enable-static \
    $OPT_SHARED \
    --disable-docs \
    --disable-examples \
    --disable-oggtest

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend