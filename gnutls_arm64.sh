#!/bin/bash

libname=gnutls
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

export PKGDIR=$INSTALL_DIR/lib/pkgconfig

[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR


checkTools make automake autoconf autogen libtool gettext texinfo tar gzip git gperf # perl nettle guile p11-kit gperf

# [ ! -d $LIBDIR/nettle/lib/pkgconfig ] && ./nettle_arm64.sh
cp -f $LIBDIR/nettle/lib/pkgconfig/*.pc $PKGDIR
cp -f $LIBDIR/gmp/lib/pkgconfig/*.pc $PKGDIR

logstart ${libname}

if [ ! -d $SRCDIR ];then

	# ERROR can't gen configure from logthis git clone https://gitlab.com/gnutls/gnutls.git
	# log clone
	# log autoconf
	# cd $SRCDIR
	# logthis autoreconf -fi
	# cd ..

	log download
	wget -O- https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.14.tar.xz 2>/dev/null | tar -xJ
	mv ${libname}-* ${libname}
	echo -ne " ok "
fi

pushd $SRCDIR >/dev/null

#log 'clean '
#${MAKE_EXECUTABLE} clean >/dev/null 2>&1
export LDFLAGS="-L$LIBDIR/gmp/lib -lgmp"
export CFLAGS="-I$LIBDIR/gmp/include"
log configure
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --enable-pic \
    --enable-static \
    $OPT_SHARED \
    --enable-hardware-acceleration \
    --with-included-libtasn1 \
    --with-included-unistring \
    --without-idn \
    --without-p11-kit \
    --disable-openssl-compatibility \
    --disable-fast-install \
    --disable-code-coverage \
    --disable-doc \
    --disable-manpages \
    --disable-guile \
    --disable-tests \
    --disable-tools \
    --disable-maintainer-mode

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

# log check
# logthis ${MAKE_EXECUTABLE} ckeck

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend