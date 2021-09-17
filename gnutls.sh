#!/bin/bash
# test-ok: win64 arm64-android
# HEADER-----------------------------------
lib='gnutls'
dsc='GnuTLS implements the TLS/SSL (Transport Layer Security aka Secure Sockets Layer) protocol'
lic='LGPL-2.1'
src='https://gitlab.com/gnutls/gnutls.git'
sty='git'
cfg='ac'
tls='gettext texinfo gperf autopoint'
dep='libiconv gmp nettle'
eta='690'
pkg='gnutls'
sh0='--enable-static --disable-shared --with-pic'
sh1='--enable-static --enable-shared'
bn0='--disable-tools'
bn1='--enable-tools'
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
CFG="--disable-doc --disable-manpages --disable-guile --disable-tests \
  --with-included-libtasn1 --with-included-unistring \
  --without-p11-kit"
CSH=$sh0
CBN=$bn0
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH=$sh1
  [[ $bshared -eq 0 ]] && CSH=$sh0
fi

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} --whithout-idn --disable-code-coverage $CFG"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG PKG_CONFIG=$(which pkg-config)"
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac

# Required function buildSrc
buildSrc(){
  #gitClone $src $lib
  #log bootstrap
  #logme $SRCDIR/bootstrap
  getTarXZ 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.14.tar.xz' $lib
  doAutoreconf $SRCDIR
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >>$LOGFILE 2>&1

  setPkgConfigDir $PKGDIR gmp nettle hogweed
  
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  
  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start