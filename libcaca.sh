#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .   clang
# GNU  F   .   .   F   gcc
# WIN  .   .   .   F   clang/gcc

lib='libcaca'
dsc='Colour AsCii Art library'
lic='GPL'
src='https://github.com/cacalabs/libcaca.git'
cfg='ac'
pkg='caca'
eta='80'

. xbuilder.sh

CFG="--disable-doc --disable-imlib2 --disable-java --disable-win32 --disable-cppunit --disable-zzuf --disable-conio"

source_config(){
  sed -i 's/^AC_PREREQ/# &/' $SRCDIR/configure.ac
  $SRCDIR/bootstrap
  sed -i 's/if defined _WIN32/if defined _MSC_VER/g' $SRCDIR/caca/caca.h \
    $SRCDIR/caca/caca0.h $SRCDIR/caca/caca0.h $SRCDIR/caca/figfont.c \
    $SRCDIR/caca/string.c
  sed -i 's/if defined(_WIN32)/if defined(_MSC_VER)/g' $SRCDIR/cxx/caca++.h
  sed -i 's/-O2 -fno-strength-reduce/-O3 -flto/g' $SRCDIR/configure
}

WFLAGS="-Wno-ignored-optimization-argument -Wno-absolute-value -Wno-unused-but-set-variable"

start

<<'XB64_PATCH'
LS0tIGNhY2EvZHJpdmVyL3dpbjMyLmMJMjAyMS0xMC0yOCAyMTozNTo0NC41MDgwMDAwMDAgKzAx
MDAKKysrIGNhY2EvZHJpdmVyL3dpbjMyLmMJMjAyMS0xMC0yOCAyMTozNTo0Ny4xMTUwMDAwMDAg
KzAxMDAKQEAgLTIzLDcgKzIzLDcgQEAKICNkZWZpbmUgV0lOMzJfTEVBTl9BTkRfTUVBTgogI2lu
Y2x1ZGUgPHdpbmRvd3MuaD4KIAotI2lmZGVmIF9fTUlOR1czMl9fCisjaWYgZGVmaW5lZChfX01J
TkdXMzJfXykgJiYgIWRlZmluZWQoX19jbGFuZ19fKQogLyogVGhpcyBpcyBtaXNzaW5nIGZyb20g
dGhlIE1pbkdXIGhlYWRlcnMuICovCiAjICAgaWYgKF9XSU4zMl9XSU5OVCA+PSAweDA1MDApCiBC
T09MIFdJTkFQSSBHZXRDdXJyZW50Q29uc29sZUZvbnQoSEFORExFIGhDb25zb2xlT3V0cHV0LCBC
T09MIGJNYXhpbXVtV2luZG93LApAQCAtMzMsNyArMzMsNiBAQAogI2lmbmRlZiBNT1VTRV9IV0hF
RUxFRAogIyAgIGRlZmluZSBNT1VTRV9IV0hFRUxFRCAweDAwMDgKICNlbmRpZgotCiAjaW5jbHVk
ZSA8c3RkbGliLmg+CiAjaW5jbHVkZSA8c3RkaW8uaD4K
XB64_PATCH

# Filelist
# --------
# include/caca++.h
# include/caca.h
# include/caca0.h
# include/caca_types.h
# include/caca_conio.h
# lib/pkgconfig/caca++.pc
# lib/pkgconfig/caca.pc
# lib/libcaca.so
# lib/libcaca++.so
# lib/libcaca++.la
# lib/libcaca.a
# lib/libcaca.la
# lib/libcaca++.a
# share/man/man1/img2txt.1
# share/man/man1/cacaserver.1
# share/man/man1/cacaview.1
# share/man/man1/cacafire.1
# share/man/man1/caca-config.1
# share/man/man1/cacaplay.1
# share/libcaca/caca.txt
# bin/caca-config
# bin/cacafire
# bin/cacaserver
# bin/img2txt
# bin/cacaclock
# bin/cacademo
# bin/cacaview
# bin/cacaplay
