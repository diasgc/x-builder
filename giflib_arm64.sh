#!/bin/bash
# TODO: ac build @ https://github.com/mirrorer/giflib

lib='giflib'
dsc='Library for manipulating GIF files'
lic=''
src='https://git.code.sf.net/p/giflib/code'
sty='git'
cfg=''
tls=''
dep=''
eta='18'

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
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_acopts $lib && exit;;
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


patchSrc(){
	cd ${libname}
	sed -i 's/PREFIX = \/usr\/local/PREFIX = ${INSTALL_DIR}/g' Makefile
	sed -i 's/CFLAGS  = -std=gnu99 -fPIC -Wall -Wno-format-truncation $(OFLAGS)/CFLAGS  = -std=gnu99 -fPIC -fPIE -Wall $(OFLAGS)/g' Makefile
	sed -i 's/$(MAKE) -C doc/# $(MAKE) -C doc/g' Makefile
	sed -i 's/install: all install-bin install-include install-lib install-man/install: all install-bin install-include install-lib/g' Makefile
	cd ..
}


logstart $lib

[ -n "$update" ] && rm -rf $SRCDIR

if [ ! -d $SRCDIR ];then
	gitClone $src $lib
	log patch
	logme patchSrc
fi

pushd $BUILDDIR >/dev/null

export PREFIX=${INSTALL_DIR}

log clean
logme ${MAKE_EXECUTABLE} clean

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

log install
logme ${MAKE_EXECUTABLE} install

createPkgConfig(){
cat <<EOF >>$PKGDIR/${lib}.pc
prefix=${INSTALL_DIR}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: giflib
Description: gif library
Version: 1
Requires:
Libs: -L\${libdir} -lgif
Cflags: -I\${includedir}
EOF
}

log pkgconfig
logme createPkgConfig

popd >/dev/null
logver $PKGDIR/$lib.pc
logend