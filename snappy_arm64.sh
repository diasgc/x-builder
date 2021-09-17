#!/bin/bash

lib='snappy'
dsc='A fast compressor/decompressor'
lic='Apache-2'
src='https://github.com/google/snappy.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta='54'

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
    --clean )		makeClean $SRCDIR && exit;;
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_acopts $lib && exit;;
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
	cd $SRCDIR
	logme autoreconf -fi
	cd ..
fi

pushd $BUILDDIR >/dev/null
 
log cmake
logme ${CMAKE_EXECUTABLE} . -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCROSS_COMPILE_ARM=ON \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
 -DCMAKE_SYSTEM_NAME=Android \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DANDROID_PLATFORM=${API} \
 -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmak \
 -DBUILD_SHARED_LIBS=$OPT_SHARED -DSNAPPY_BUILD_TESTS=OFF

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

createPkgConfig(){
cat <<EOF >>$PKGDIR/$lib.pc
prefix=${INSTALL_DIR}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: Snappy
Description: Snappy is a compression/decompression library
Version: 1.1.8
Requires:
Libs: -L\${libdir} -lsnappy
Cflags: -I\${includedir}
EOF
}

log pkgconfig
logme createPkgConfig

popd >/dev/null
logver $PKGDIR/$lib.pc
logend