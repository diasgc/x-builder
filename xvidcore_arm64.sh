#!/bin/bash

libname=xvidcore
archname=arm64v8
eta=51

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. tcutils.sh arm64 29

export LIBSDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export BUILDDIR=$SRCDIR/build/generic
export INSTALL_DIR=$LIBSDIR/${libname}
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR
			exit 
                        ;;
	--clearall )    rm -rf ${libname}
			exit
			;;
	--opts )	./$BUILDDIR/configure --help >${libname}_opts.txt
			exit
			;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall|--opts]\e[36m[--shared][--bin]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit
    esac
    shift
done



[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

logstart ${libname}

if [ ! -d $SRCDIR ];then
	getTarGZ https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.gz
fi

pushd $BUILDDIR >/dev/null

log configure
logme ./configure --prefix=$INSTALL_DIR --host=$TARGET

#--with-sysroot=$SYSROOT --with-pic --enable-static $OPT_SHARED \

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logme ${MAKE_EXECUTABLE} install

createPkgConfig(){
cat <<EOF >>$PKGDIR/${libname}.pc
prefix=${INSTALL_DIR}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: xvidcore
Description: xvidcore library
Version: 1.3.7
Requires:
Libs: -L\${libdir} -lxvidcore
Cflags: -I\${includedir}
EOF
}

log pkgconfig
logme createPkgConfig

popd >/dev/null
logver $PKGDIR/${libname}.pc
logend