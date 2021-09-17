#!/bin/bash

lib='libjpeg'
dsc='JPEG image codec that uses SIMD instructions'
lic='BSD'
src='https://github.com/libjpeg-turbo/libjpeg-turbo.git'
sty='git'
cfg='cm'
tls=''
dep=''
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
OPT_BIN=
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

if [ -z "$update" ] && [ -f $PKGDIR/$lib.pc ] && [ -f $INSTALL_DIR/lib/$lib.a ]; then
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
fi

pushd $BUILDDIR >/dev/null

log cmake
logme ${CMAKE_EXECUTABLE} . \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_SYSTEM_NAME=Linux \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_AR=${LLVM_AR} \
 -DENABLE_SHARED=$OPT_SHARED \
 -DWITH_JPEG8=ON \
 -DWITH_JPEG7=ON

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$lib.pc
logend
