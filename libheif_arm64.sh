#!/bin/bash

libname=libheif
archname=arm64v8

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. $(pwd)/tc_aarch64-linux-android.sh

shared_opts="--disable-shared"
bin_opts="--disable-examples"

while [ "$1" != "" ]; do
    case $1 in
        --clean )	cd ${libname} && make clean && cd ..
			exit 
                        ;;
	--clearall ) 	rm -rf ${libname}
			exit
			;;
	--opts )	show_autoconfopts ${libname}
      			exit
			;;
	--shared )	shared_opts="--enable-shared"
			;;
	--bin )		bin_opts="--enable-examples"
			;;
	* )  		echo -e "\n\n\tlibheif builder 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tDependencies:\taom x265 libjpeg libpng\n\tTools:\t\tcmake/ndk make pkg-config\n\n\e[0m"
		        exit
		        ;;
    esac
    shift
done

export LIBDIR=$(pwd)/${archname}
export INSTALL_DIR=$LIBDIR/${libname}
export PKGDIR=$INSTALL_DIR/pkgconfig

if [ -d "${INSTALL_DIR}" ];then
	rm -rf ${INSTALL_DIR}
fi
mkdir -p $PKGDIR

checkDependencies $LIBDIR $PKGDIR aom x265 libjpeg libpng

logstart ${libname}


if [ ! -d "$(pwd)/${libname}" ];then
	log clone
	logthis git clone https://github.com/strukturag/libheif.git
	cd ${libname}
	log autogen
	logthis ./autogen.sh
	cd ..	
fi

cd ${libname}

export PKG_CONFIG_PATH=$PKGDIR:$PKG_CONFIG_PATH
export LDFLAGS="-L$SYSROOT/usr/lib/aarch-linux-android -lc++_shared -lm"

log configure
logthis ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --with-sysroot=${SYSROOT} \
    --with-pic \
    $shared_opts \
    --disable-gdk-pixbuf \
    --disable-tests \
    $bin_opts \
    --disable-libfuzzer \


log make
logthis ${MAKE_EXECUTABLE} -j${HOST_NPROC}
log install
logthis ${MAKE_EXECUTABLE} install
cd ../..
logend