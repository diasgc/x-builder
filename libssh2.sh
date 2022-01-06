#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP+  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libssh2'
dsc='the SSH library'
lic='GLP-2.0'
src='https://github.com/libssh2/libssh2.git'
dep='openssl' # or Libgcrypt or mbedTLS
cfg='cmake' # or ar
eta='0'
CFG='-DBUILD_TESTING=OFF -DINSTALL_DOCS=OFF'
#cshk=''
#cstk=''
cbk='BUILD_EXAMPLES'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start

<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMudHh0CTIwMjEtMTAtMTggMjE6NDY6MjcuMDQ1MDAwMDAwICswMTAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIxLTEwLTE4IDIxOjQ3OjExLjQ1NDg1OTEwMCArMDEwMApAQCAt
NTAsNiArNTAsNyBAQAogZW5kaWYoKQogCiBvcHRpb24oQlVJTERfU0hBUkVEX0xJQlMgIkJ1aWxk
IFNoYXJlZCBMaWJyYXJpZXMiIE9GRikKK29wdGlvbihJTlNUQUxMX0RPQ1MgIkluc3RhbGwgRG9j
cyIgT0ZGKQogCiAjIFBhcnNlIHZlcnNpb24KIApAQCAtMTA2LDcgKzEwNyw5IEBACiAgIGFkZF9k
ZXBlbmRlbmNpZXMobGlic3NoMiBsaW50KQogZW5kaWYoKQogCitpZihJTlNUQUxMX0RPQ1MpCiBh
ZGRfc3ViZGlyZWN0b3J5KGRvY3MpCitlbmRpZigpCiAKIGZlYXR1cmVfc3VtbWFyeShXSEFUIEFM
TCkK
XB64_PATCH

# Filelist
# --------
# include/libssh2_sftp.h
# include/libssh2.h
# include/libssh2_publickey.h
# lib/pkgconfig/libssh2.pc
# lib/cmake/libssh2/Libssh2ConfigVersion.cmake
# lib/cmake/libssh2/Libssh2Config-release.cmake
# lib/cmake/libssh2/Libssh2Config.cmake
# lib/libssh2.so
# share/doc/libssh2/NEWS
# share/doc/libssh2/AUTHORS
# share/doc/libssh2/RELEASE-NOTES
# share/doc/libssh2/HACKING
# share/doc/libssh2/COPYING
# share/doc/libssh2/README
