#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='gnutls'
dsc='GnuTLS implements the TLS/SSL (Transport Layer Security aka Secure Sockets Layer) protocol'
lic='LGPL-2.1'
src='https://gitlab.com/gnutls/gnutls.git'
cfg='ac'
tls='gettext texinfo gperf autopoint'
dep='libiconv gmp nettle'
eta='690'
cbk='able-tools'

. xbuilder.sh

vrs="3.6.16"
src="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-${vrs}.tar.xz"
sty="txz"

CFG="--with-sysroot=${SYSROOT} --with-pic --enable-local-libopts \
  --with-included-libtasn1 --with-included-unistring --without-p11-kit \
  --disable-doc --disable-manpages --disable-guile --disable-tests"

source_patch(){
  pushdir $SRCDIR
  ./bootstrap >>$LOGFILE 2>&1
  popdir
}

start

# Filelist
# --------

# include/gnutls/pkcs12.h
# include/gnutls/crypto.h
# include/gnutls/dtls.h
# include/gnutls/x509.h
# include/gnutls/gnutlsxx.h
# include/gnutls/x509-ext.h
# include/gnutls/self-test.h
# include/gnutls/pkcs7.h
# include/gnutls/urls.h
# include/gnutls/system-keys.h
# include/gnutls/tpm.h
# include/gnutls/compat.h
# include/gnutls/abstract.h
# include/gnutls/openpgp.h
# include/gnutls/ocsp.h
# include/gnutls/gnutls.h
# include/gnutls/socket.h
# include/gnutls/pkcs11.h
# lib/pkgconfig/gnutls.pc
# lib/libgnutls.so
# lib/libgnutlsxx.a
# lib/libgnutlsxx.la
# lib/libgnutls.a
# lib/libgnutls.la
# lib/libgnutlsxx.so
# bin/gnutls-serv
# bin/srptool
# bin/psktool
# bin/gnutls-cli
# bin/ocsptool
# bin/certtool
# bin/gnutls-cli-debug
