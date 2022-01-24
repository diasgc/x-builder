#!/bin/bash

lib='gnutls'
dsc='GnuTLS implements the TLS/SSL (Transport Layer Security aka Secure Sockets Layer) protocol'
lic='LGPL-2.1'
src='https://gitlab.com/gnutls/gnutls.git'
cfg='ac'
automake_cmd='./bootstrap'
dep='libiconv gmp nettle'
eta='690'
cbk='able-tools'

lst_inc='gnutls/*.h'
lst_lib='libgnutls.* libgnutlsxx.*'
lst_bin='gnutls-serv srptool psktool gnutls-cli ocsptool certtool gnutls-cli-debug'
lst_lic='LICENSE'
lst_pc='gnutls.pc'

. xbuilder.sh

vrs="3.6.16"
src="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/gnutls-${vrs}.tar.xz"

CFG="--enable-local-libopts --with-included-libtasn1 --with-included-unistring --without-p11-kit --disable-doc --disable-manpages --disable-guile --disable-tests"

start

# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc