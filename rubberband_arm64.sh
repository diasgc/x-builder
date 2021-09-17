#!/bin/bash

libname=rubberband
archname=arm64v8
eta=172

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. tcutils.sh arm64 29

export LIBSDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export BUILDDIR=$SRCDIR
export INSTALL_DIR=$LIBSDIR/${libname}
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED="--disable-shared"
OPT_BIN="--disable-apps"

while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR && exit;;
	--clearall )    rm -rf ${libname} && exit;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit
    esac
    shift
done

[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

chkDeps libsndfile libsamplerate

logstart ${libname}

if [ ! -d $SRCDIR ];then
	gitClone https://github.com/breakfastquay/rubberband.git $libname
	log patch
	cd $SRCDIR
	rm -f configure.ac && cp ../rubberband.ac configure.ac
	rm -f Makefile.in && cp ../rubberband.makefile Makefile.in
	logme autoreconf -fi
	cd ..
fi

pushd $BUILDDIR >/dev/null

log configure
logme ./configure --prefix=$INSTALL_DIR --host=$TARGET

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install
cp rubberband.pc $PKGDIR
echo -e "\nRequires: sndfile, samplerate" >>$PKGDIR/rubberband.pc

popd >/dev/null
logver $PKGDIR/${libname}.pc
logend