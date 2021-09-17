#!/bin/bash

lib='libjbig'
dsc='JBIG1 data compression standard (ITU-T T.82) lossless image compression'
lic='GPL'
src='https://www.cl.cam.ac.uk/~mgk25/git/jbigkit'
sty='git'
cfg=''
tls=''
dep=''
eta='17'

arch=arm64

LOGFILE=$(pwd)/${lib}_${arch}.log

# enable ndk toolchain for arm64
. tcutils.sh $arch 29

export LIBSDIR=$(pwd)/${arch}
export SRCDIR=$(pwd)/$lib
export BUILDDIR=$SRCDIR/libjbig
export INSTALL_DIR=$LIBSDIR/$lib
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED=
OPT_BIN=
update=

while [ "$1" != "" ]; do
  case $1 in
    --clean )		makeClean $SRCDIR && exit;;
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_acopts $lib && exit;;
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
mkdir -p $INSTALL_DIR/include
export PKG_CONFIG_PATH=$PKGDIR

# Check Tools and Dependencies
chkTools $tls
chkDeps $dep

logstart $lib

[ -n "$update" ] && rm -rf $SRCDIR

if [ ! -d $SRCDIR ];then
	gitClone $src $lib
	log autogen
	pushd $BUILDDIR >/dev/null
	sed -i 's|CC = gcc|CC = '$CC'|g' Makefile
	sed -i 's|ar rc|'$AR' rc|g' Makefile
	sed -i 's|-ranlib|-'$RANLIB'|g' Makefile
	popd >/dev/null
fi

pushd $BUILDDIR >/dev/null

log make
logme ${MAKE_EXECUTABLE} libjbig.a libjbig85.a -j${HOST_NPROC}
log install
cp *.a ${INSTALL_DIR}/lib
cp *.h ${INSTALL_DIR}/include

createPkgConfig(){
cat <<EOF >>$PKGDIR/$lib.pc
prefix=${INSTALL_DIR}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: libjbig
Description: JBIG1 data compression standard (ITU-T T.82) lossless image compression
Version: 2.1
Requires:
Libs: -L\${libdir} -ljbig -ljbig85
Cflags: -I\${includedir}
EOF
}

log pkgconfig
logme createPkgConfig

popd >/dev/null
logver $PKGDIR/$lib.pc
logend