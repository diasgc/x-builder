#!/bin/bash

lib='wavpack'
dsc='WavPack encode/decode library, command-line programs, and several plugins'
lic='BSD 3-clause'
src='https://github.com/dbry/WavPack.git'
sty='git'
cfg='ac'
tls=''
dep='libiconv'
eta='172'

arch=arm64

	gitClone  ${libname}
	cd $SRCDIR
	log autoreconf
	logme autoreconf -fi
	cd ..
	
LOGFILE=$(pwd)/${lib}_${arch}.log

# enable ndk toolchain for arm64
. tcutils.sh $arch 29

export LIBSDIR=$(pwd)/${arch}
export SRCDIR=$(pwd)/$lib
export BUILDDIR=$SRCDIR
export INSTALL_DIR=$LIBSDIR/$lib
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED="--disable-shared"
OPT_BIN="--disable-apps"
update=

while [ "$1" != "" ]; do
  case $1 in
    --clean )		makeClean $SRCDIR && exit;;
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_acopts $lib && exit;;
	--shared )		OPT_SHARED="--enable-shared";;
    --bin )			OPT_BIN="--enable-apps";;
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
	log autoreconf
	logme autoreconf -fi
	cd ..
fi

pushd $BUILDDIR >/dev/null

log configure
logme ./configure \
    --prefix=$INSTALL_DIR \
    --host=$TARGET \
    --with-sysroot=$SYSROOT \
    --with-pic \
    --enable-static \
    --disable-asm \
    --disable-dsd \
    --enable-legacy \
    --disable-tests \
    --enable-rpath \
    $OPT_SHARED $OPT_BIN

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$lib.pc
logend