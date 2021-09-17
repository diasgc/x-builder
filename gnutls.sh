#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='gnutls'
dsc='GnuTLS implements the TLS/SSL (Transport Layer Security aka Secure Sockets Layer) protocol'
lic='LGPL-2.1'
src='https://gitlab.com/gnutls/gnutls.git'
sty='git'
cfg='ar'
tls='gettext texinfo gperf autopoint'
dep='libiconv gmp nettle'
pkg='gnutls'

eta='690'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

sh0='--enable-static --disable-shared --with-pic'
sh1='--enable-static --enable-shared'
cb0='--disable-tools'
cb1='--enable-tools'
CSH=$sh0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR
CFG="--disable-doc --disable-manpages --disable-guile --disable-tests \
  --with-included-libtasn1 --with-included-unistring \
  --without-p11-kit"
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT}"


buildSrc(){
  #gitClone $src $lib
  #log bootstrap
  #logme $SRCDIR/bootstrap
  getTarXZ 'https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-3.6.14.tar.xz' $lib
}

beforeBuild(){
  setPkgConfigDir $PKGDIR gmp nettle hogweed
}

start