#!/bin/bash

lib='exiv2'
dsc='Image metadata library and tools'
lic=''
src='https://github.com/Exiv2/exiv2.git'
sty='git'
cfg='cm'
tls=''
dep='expat libiconv libpng'
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

OPT_SHARED=
OPT_BIN=
update=

while [ "$1" != "" ]; do
  case $1 in
    --clean )		cmakeClean $SRCDIR && exit;;
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_cmakeopts $lib && exit;;
	--shared )		OPT_SHARED=;;
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
 -DANDROID_PLATFORM=${ANDROID_PLATFORM} \
 -DANDROID_ABI=${ANDROID_ABI} \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_TOOLCHAIN_FILE=../${lib}_android.cmake \
 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
 -DCMAKE_CROSSCOMPILING=TRUE \
 -DBUILD_SHARED_LIBS=$OPT_SHARED \
 -DEXIV2_ENABLE_DYNAMIC_RUNTIME=OFF \
 -DEXIV2_BUILD_SAMPLES=OFF \
 -DBUILD_TESTING=OFF \
 -DEXIV2_ENABLE_PRINTUCS2=OFF \
 -DEXIV2_ENABLE_PNG=ON \
 -DEXIV2_ENABLE_XMP=OFF
 #-DEXPAT_INCLUDE_DIR=$LIBSDIR/expat/include \
 #-DEXPAT_LIBRARY=$LIBSDIR/expat/lib/expat.a \
 #-DIconv_INCLUDE_DIR=$LIBSDIR/libiconv/include \
 #-DIconv_LIBRARY=$LIBSDIR/libiconv/lib/libiconv.a \

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$lib.pc
logend