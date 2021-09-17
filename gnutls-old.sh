#!/bin/bash
# HEADER-----------------------------------
lib='gnutls'
dsc='GnuTLS implements the TLS/SSL (Transport Layer Security aka Secure Sockets Layer) protocol'
lic='LGPL-2.1'
src='https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.14.tar.xz'
sty='txz'
cfg='ac'
tls='gettext texinfo gperf'
dep='gmp nettle'
eta='690'
pkg='gnutls'

# -----------------------------------------

# required extraopts
extraOpts(){
  case $1 in
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG="--enable-hardware-acceleration \
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
    --disable-maintainer-mode"
CSH="--enable-static --disable-shared --with-pic=1"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared"
fi

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} --with-pic=1 $CFG"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="CC_FOR_BUILD=cc --host=${arch} --with-sysroot=/usr/$arch $CFG"
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac

# Required function buildSrc
buildSrc(){
	# todo: fail aclocal: error: couldn't open directory 'src/gl/m4':
	# No such file or directory. autoreconf: aclocal failed with exit status: 1
    # gitClone $src $lib # https://gitlab.com/gnutls/gnutls.git
	# doAutoreconf $SRCDIR
  getTarXZ $src $lib
  #[ -f $PKGDIR/nettle.pc ] || cp $LIBSDIR/nettle/lib64/*.pc $PKGDIR
  #[ -f $PKGDIR/gmp.pc ] || cp $LIBSDIR/gmp/lib/*.pc $PKGDIR
}

# Required function buildLib
buildLib(){

  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN PKG_CONFIG_PATH=$PKGDIR \
  GMP_CFLAGS="-I$LIBSDIR/gmp/include" \
  GMP_LIBS="-L$LIBSDIR/gmp/lib -lgmp"
  NETTLE_CFLAGS="-I$LIBSDIR/nettle/include" \
  NETTLE_LIBS="-L$LIBSDIR/nettle/lib64 -lnettle -L$LIBSDIR/gmp/lib -lgmp" \
  HOGWEED_CFLAGS="-I$LIBSDIR/nettle/include" \
  HOGWEED_LIBS="-L$LIBSDIR/nettle/lib64 -lhogweed  -L$LIBSDIR/gmp/lib -lgmp" \
  

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start