#!/bin/bash

libname=freetype
archname=arm64v8


# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

while [ "$1" != "" ]; do
    case $1 in
        --clean )	cd ${libname} && make clean && cd ..
			exit 
                        ;;
	--clearall )    rm -rf ${libname}
			exit
			;;
	--opts )	show_autoconfopts ${libname}
			exit
			;;
        * )             echo --clean|--clearall
                        exit 1
    esac
    shift
done

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PATH="$(pwd)/${archname}":$PATH
export LIBPNG=${LIBDIR}/libpng
export ZLIB=${LIBDIR}/zlib
export PKGDIR=$INSTALL_DIR/pkgconfig

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir -p $PKGDIR

checkDependencies $LIBDIR $PKGDIR libpng

# [ ! -f $LIBPNG/lib/libpng.a ] && ./libpng_arm64.sh
# [ ! -f $ZLIB/lib/libz.a ] && ./zlib_arm64.sh

logstart ${libname}

if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://git.sv.nongnu.org/r/freetype/freetype2.git freetype
	cd ${libname}
	log autogen
	logthis ./autogen.sh
	cd ..
fi

cd ${libname}


export LIBPNG_CFLAGS="-I${LIBPNG}/include"
export LIBPNG_LIBS="-L${LIBPNG}/lib"
export LIBS="-lz"

log configure
logthis ./configure \
  --prefix=${INSTALL_DIR} \
  --host=${TARGET} \
  --with-sysroot=${SYSROOT} \
  --with-pic \
  --enable-static \
  --disable-shared \
  --disable-fast-install \
  --disable-mmap \
  --without-harfbuzz \
  --without-bzip2 \
  --without-fsref \
  --without-quickdraw-toolbox \
  --without-quickdraw-carbon \
  --without-ats \
  --with-zlib \
  --with-png

log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ..
logend