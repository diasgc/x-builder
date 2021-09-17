#!/bin/bash

libname=lcms2
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

while [ "$1" != "" ]; do
    case $1 in
        --clean )	cd ${libname} && make clean && cd ..
			exit 
                        ;;
	--clearall )    rm -rf ${libname}
			exit
			;;
	--opts )	show_autoconfopts ${libname}
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

check_autotools

logstart ${libname}

export LIBSDIR=$(pwd)/${archname}
export INSTALL_DIR=${LIBSDIR}/${libname}
export PATH="$(pwd)/${archname}":$PATH
export PKGDIR=$INSTALL_DIR/pkgconfig
export PKG_CONFIG_PATH=$PKGDIR

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir -p ${PKGDIR}

check_autotools
[ ! -f ${LIBSDIR}/libjpeg/lib/pkgconfig/libjpeg.pc ] && ./libjpeg_arm64.sh
cp -f ${LIBSDIR}/libjpeg/lib/pkgconfig/libjpeg.pc ${PKGDIR}
[ ! -f ${LIBSDIR}/libtiff/lib/pkgconfig/libtiff-4.pc ] && ./libtiff_arm64.sh
cp -f ${LIBSDIR}/libtiff/lib/pkgconfig/libtiff-4.pc ${PKGDIR}

#dep libc6_2.23-0ubuntu3_arm64.deb

if [ ! -d "$(pwd)/${libname}" ];then
	log download
	wget -O- https://github.com/mm2/Little-CMS/archive/lcms2.10.tar.gz 2> /dev/null | tar xz
	mv Little*${libname}* ${libname}
	echo -ne " ok "
	log autoreconf
	cd ${libname}
	logthis autoreconf -f -i
	cd ..
fi

cd ${libname}
log configure
logthis ./configure \
  --prefix=${INSTALL_DIR} \
  --host=${TARGET} \
  --with-pic=1 \
  --with-sysroot=${SYSROOT} \
  --enable-static \
  --disable-shared \
  --with-jpeg=${LIBSDIR}/libjpeg \
  --with-tiff=${LIBSDIR}/libtiff

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend