#!/bin/bash

lib='aom'
dsc='Alliance for Open Media AV1 codec'
lic='BSD 2-clause'
src='https://aomedia.googlesource.com/aom'
sty='git'
cfg='cm'
tls='pearl'
dep='cpu_features'
eta='424'

arch='arm64'

LOGFILE=$(pwd)/${lib}_${arch}.log

# enable ndk toolchain for arm64
. tcutils.sh $arch 29

export LIBSDIR=$(pwd)/${arch}
export SRCDIR=$(pwd)/$lib
export BUILDDIR=$(pwd)/${lib}_build_${arch}
export INSTALL_DIR=$LIBSDIR/$lib
export PKGDIR=$INSTALL_DIR/lib/pkgconfig
[ "$SRCDIR" != "$BUILDDIR" ] && mkdir -p $BUILDDIR

XCFG="-DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake \
 -DCMAKE_SYSTEM_NAME=Android \
 -DANDROID_ABI=$ANDROID_ABI \
 -DANDROID_PLATFORM=$API \
 -DCMAKE_SYSTEM_PROCESSOR=aarch64
 -DARCH_ARM=1 \
 -DCONFIG_RUNTIME_CPU_DETECT=0 \
 -DCONFIG_PIC=1"

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
	log $lib
	logver $PKGDIR/$lib.pc
	log 'done'
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
logme ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR $XCFG \
 -DENABLE_TESTS=0 \
 -DENABLE_EXAMPLES=OFF \
 -DENABLE_DOCS=OFF

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$lib.pc
logend