#!/bin/bash

lib='gnutls'
dsc='Secure communications library implementing the SSL, TLS and DTLS protocols and technologies around them'
lic='LGPL-2.1'
src='https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.14.tar.xz'
sty='txz'
cfg='ac'
tls='gettext texinfo gperf'
dep='nettle gmp'
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
	getTarXZ $src $lib
	# ERROR can't gen configure from logme git clone https://gitlab.com/gnutls/gnutls.git
	# log clone
	# log bootstrap
	# cd $SRCDIR
	# logme ./bootstrap
	# cd ..
fi

pushd $BUILDDIR >/dev/null

export LDFLAGS="-L$LIBDIR/gmp/lib -lgmp"
export CFLAGS="-I$LIBDIR/gmp/include"
log configure
logme ./configure \
    --prefix=${INSTALL_DIR} \
    --host=aarch64-linux-android \
    --enable-pic \
    --enable-static $OPT_SHARED \
    --enable-hardware-acceleration \
    --with-included-libtasn1 \
    --with-included-unistring \
    --without-idn \
    --without-p11-kit \
    --disable-openssl-compatibility \
    --disable-fast-install \
    --disable-code-coverage \
    --disable-doc \
    --disable-manpages \
    --disable-guile \
    --disable-tests \
    --disable-tools \
    --disable-maintainer-mode

log make
logme ${MAKE_EXECUTABLE} -j${HOST_NPROC} 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/$lib.pc
logend