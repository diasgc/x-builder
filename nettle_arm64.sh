#!/bin/bash

libname=nettle
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

export LIBDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH


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
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make automake autoconf autogen libtool gettext texinfo tar gzip git perl nettle guile p11-kit gperf\n\n\e[0m"
		        exit
    esac
    shift
done

export PKGDIR=$INSTALL_DIR/pkgconfig

[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR

checkTools make automake autoconf autogen
checkDependencies $LIBDIR $PKGDIR gmp

logstart ${libname}

if [ ! -d $SRCDIR ];then
	log clone
	logthis git clone https://github.com/gnutls/nettle.git
	log autoconf
	cd $SRCDIR
	# todo: fail aclocal: error: couldn't open directory 'src/gl/m4': No such file or directory. autoreconf: aclocal failed with exit status: 1
	logthis autoreconf -fi
	cd ..
fi



pushd $SRCDIR >/dev/null

log 'clean '
${MAKE_EXECUTABLE} clean >/dev/null 2>&1

log cmake
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --enable-pic \
    --enable-static \
    $OPT_SHARED \
    --with-include-path=$LIBDIR/gmp/include \
    --with-lib-path=$LIBDIR/gmp/lib \
    --disable-mini-gmp \
    --disable-openssl \
    --disable-gcov \
    --disable-documentation
#   --disable-assembler \

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend