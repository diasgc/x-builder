#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='aria2'
dsc='The ultra fast download utility'
lic='GLP-2.0'
src='https://github.com/aria2/aria2.git'
url='https://aria2.github.io/'
cfg='ar'
dep='gmp nettle expat gnutls libssh2 libsqlite3 libcares'
eta='0'

$host_ndk && CFG="--disable-nls --without-gnutls --with-openssl --without-sqlite3 --without-libxml2 --with-libexpat --with-libcares --with-libz --with-libssh2"
    #CXXFLAGS="-Os -g" \
    #CFLAGS="-Os -g" \
    #CPPFLAGS="-fPIE" \
    #LDFLAGS="-fPIE -pie -L$PREFIX/lib -static-libstdc++" \
    #PKG_CONFIG_LIBDIR="$PREFIX/lib/pkgconfig""
#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start