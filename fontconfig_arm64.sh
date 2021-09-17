#!/bin/bash

lib='fontconfig'
dsc=''
lic=''
src='https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
sty='git'
cfg='ac'
tls='gperf gettext autopoint'
dep='libiconv freetype expat libxml2 json-c'
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
    --clean )		makeClean $SRCDIR && exit;;
	--clearall )    rm -rf $SRCDIR $INSTALL_DIR $BUILDDIR && exit;;
	--opts )		show_acopts $lib && exit;;
	--shared )		OPT_SHARED="--enable-shared";;
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
	cd ${libname}
	log autoreconf
	logme autoreconf -fi
	cd ..	
fi

pushd $BUILDDIR >/dev/null

log configure
logme ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --with-arch=aarch64 \
    --with-sysroot=${SYSROOT} \
    --with-pic \
    --without-libintl-prefix \
    --enable-static $OPT_SHARED \
    --disable-fast-install \
    --disable-rpath \
    --disable-docs
	
# --with-libiconv-prefix=${LIBDIR}/libiconv \
# --with-expat=${LIBDIR}/libexpat \
# export FREETYPE_LIBS="-L${LIBDIR}/freetype/lib"
# export FREETYPE_CFLAGS="-I${LIBDIR}/freetype/include/freetype2 -I${LIBDIR}/freetype/include/freetype2/freetype -I${LIBDIR}/freetype/include/freetype2/freetype/config"
# export JSONC_LIBS="-L${LIBDIR}/json-c/lib"
# export JSONC_CFLAGS="-I${LIBDIR}/json-c/include"
# export EXPAT_LIBS="-L${LIBDIR}/libexpat/lib"
# export EXPAT_CFLAGS="-I${LIBDIR}/libexpat/include"

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$lib.pc
logend