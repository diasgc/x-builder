#!/bin/bash

lib='frei0r'
dsc='A large collection of free and portable video plugins'
lic='GPL-2.0'
cfg='ac cm'
src='https://github.com/dyne/frei0r.git'
sty='git'
tls=''
dep=''
xdp='gavl opencv libcairo'
eta='275'

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
    --clean )		makeClean $SRCDIR && exit;;
    --clearall )	rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
    --opts )		show_acopts $lib && exit;;
    --shared )		OPT_SHARED="--enable-shared";;
    --update )		update=1;;
    * )			usage && exit;;
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
	log autogen
	cd $SRCDIR
	logme ./autogen.sh
	cd ..
fi

pushd $BUILDDIR >/dev/null

log configure
logme ./configure \
    --prefix=$INSTALL_DIR \
    --host=$TARGET --with-sysroot=$SYSROOT \
    --with-pic --enable-static $OPT_SHARED $OPT_BIN

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$lib.pc
logend