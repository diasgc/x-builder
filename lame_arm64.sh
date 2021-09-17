#!/bin/bash

libname=lame
archname=arm64v8
eta=180

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

export LIBDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export INSTALL_DIR=$LIBDIR/${libname}

OPT_SHARED="--disable-shared"
OPT_BIN="--disable-frontend"
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
	--bin ) 	OPT_BIN="--enable-frontend"
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
checkDependencies libiconv

logstart ${libname}

if [ ! -d $SRCDIR ];then
	log download
	wget -O- https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz/download 2>/dev/null | tar -xz
	mv ${libname}-* ${libname}
	echo -ne " ok "
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
    --enable-static \
    --with-libiconv-prefix=$LIBDIR/libiconv \
    $OPT_SHARED $OPT_BIN\

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend