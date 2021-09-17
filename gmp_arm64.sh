#!/bin/bash

libname=gmp
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
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared]\e[90m\n\n\tTools:make automake autoconf autogen libtool gettext texinfo tar gzip git perl nettle guile p11-kit gperf\n\n\e[0m"
		        exit
    esac
    shift
done

# checkTools make automake autoconf autogen libtool gettext texinfo tar gzip git gperf # perl nettle guile p11-kit gperf
# checkDependencies gmp

# Request tool: LZIP
[ -z $(which lzip) ] && sudo apt -qq install lzip -y >/dev/null 2>&1

logstart ${libname}

if [ ! -d $SRCDIR ];then
	log download
	wget -O- https://gmplib.org/download/gmp/gmp-6.2.0.tar.lz 2>/dev/null | tar --lzip -xv >/dev/null 2>&1
	mv ${libname}-* ${libname}
	echo -ne " ok "
fi

[ -d "${INSTALL_DIR}" ] && rm -rf ${INSTALL_DIR}
mkdir ${INSTALL_DIR}

pushd $SRCDIR >/dev/null

log 'clean '
${MAKE_EXECUTABLE} clean >/dev/null 2>&1

log cmake
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --with-sysroot=${SYSROOT} \
    --enable-pic \
    --enable-static \
    --enable-cxx \
    $OPT_SHARED
#    --disable-assembly \
#    --disable-fast-install \
#    --disable-maintainer-mode \

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log check
logthis ${MAKE_EXECUTABLE} check

log install
logthis ${MAKE_EXECUTABLE} install

popd >/dev/null
logend