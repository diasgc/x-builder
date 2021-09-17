#!/bin/bash

lib='chromaprint'
dsc='C library for generating audio fingerprints used by AcoustID'
lic='LGPL-2.1'
src='https://github.com/acoustid/chromaprint.git'
sty='git'
cfg='cm'
tls=''
dep='cpu_features'
eta=''

arch=arm64

LOGFILE=$(pwd)/${lib}_${arch}.log

# enable ndk toolchain for arm64
. tcutils.sh $arch 29

export LIBSDIR=$(pwd)/${arch}
export SRCDIR=$(pwd)/$lib
export BUILDDIR=$SRCDIR
export INSTALL_DIR=$LIBSDIR/$lib
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED=OFF
update=

while [ "$1" != "" ]; do
  case $1 in
    --clean )		cmakeClean $SRCDIR && exit;;
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_cmakeopts $lib && exit;;
	--shared )		OPT_SHARED=ON;;
	--update )		update=1;;
	* )  			usage && exit;;
  esac
  shift
done

if [ -z "$update" ] && [ -f $PKGDIR/libchromaprint.pc ] && [ -f $INSTALL_DIR/lib/libchromaprint.a ]; then
	logstart $lib
	logver $PKGDIR/$lib.pc
	logend
	exit 0
fi
	
# Reset LOGFILE
[ -f $LOGFILE ] && rm -f $LOGFILE

# Reset INSTALL_DIR
[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR

# Create INSTALL_DIR and PKGCONFIG DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

# Check Tools and Dependencies
chkTools $tls
chkDeps $dep

logstart $lib

[ -n "$update" ] && rm -rf $SRCDIR

if [ ! -d $SRCDIR ];then
	gitClone $src $lib
	cd $SRCDIR
	log kissfft
	logme git clone https://github.com/mborgerding/kissfft.git
	cd ..
fi

pushd $BUILDDIR >/dev/null

log cmake
logme ${CMAKE_EXECUTABLE} . \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_SYSTEM_NAME=Android \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DANDROID_PLATFORM=${API} \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_POSITION_INDEPENDENT_CODE=1 \
 -DBUILD_SHARED_LIBS=$OPT_SHARED \
 -DKISSFFT_SOURCE_DIR=$SRCDIR/kissfft \
 -DFFT_LIB=kissfft

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/libchromaprint.pc
logend