#!/bin/bash

libname=opus
archname=arm64v8
eta=208

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

export LIBDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export INSTALL_DIR=$LIBDIR/${libname}

OPT_SHARED="--disable-shared"
OPT_BIN="--disable-extra-programs"

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
	--bin )		OPT_BIN="--enable-extra-programs"
			;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make automake autoconf libtool m4\n\n\e[0m"
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
	logthis git clone https://github.com/xiph/opus.git ${libname}
	log autogen
	cd $SRCDIR
	logthis ./autogen.sh
	cd ..
fi

pushd $SRCDIR >/dev/null

#log 'clean '
#${MAKE_EXECUTABLE} clean >/dev/null 2>&1
export AS=$YASM
log configure
logthis ./configure \
    --prefix=$INSTALL_DIR \
    --host=aarch64-linux-android \
    --with-sysroot=$SYSROOT \
    --with-pic \
    --disable-doc \
    --enable-static $OPT_SHARED $OPT_BIN

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend