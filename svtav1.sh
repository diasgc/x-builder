#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP+  .   .   .   clang
# GNU  .   .   .  PP++ gcc
# WIN  .   .   .   .   clang/gcc

lib='svtav1'
dsc='SVT (Scalable Video Technology) for AV1 encoder/decoder library'
lic='BSD'
src='https://github.com/OpenVisualCloud/SVT-AV1.git'
cfg='cmake'
pkg='SvtAv1Enc'
eta='45'
cbk="BUILD_APPS"

CFG="-DBUILD_TESTING=OFF"

. xbuilder.sh

$host_ndk && LDFLAGS+=" -L$SYSROOT/usr/${arch}/lib -llog"
WFLAGS='-Wno-unused-command-line-argument'

start

# patch Source/Lib/Common/Codec/EbThreads.(c/h) to support android
# and CMakeLists.txt to support clang (check_both_flags_add(-mno-avx))
# do not edit
<<'XB64_PATCH'
LS0tIFNvdXJjZS9MaWIvQ29tbW9uL0NvZGVjL0ViVGhyZWFkcy5jCTIwMjEtMTAtMzAgMTc6NTI6
MjguNjM1MDQ2MzAwICswMTAwCisrKyBTb3VyY2UvTGliL0NvbW1vbi9Db2RlYy9FYlRocmVhZHMu
YwkyMDIxLTEwLTMwIDE3OjUxOjEzLjE5NTA0NjMwMCArMDEwMApAQCAtODEsNyArODEsNyBAQAog
ICAgIGlmICh0aCA9PSBOVUxMKQogICAgICAgICByZXR1cm4gTlVMTDsKIAotI2lmICFkZWZpbmVk
KEVCX1RIUkVBRF9TQU5JVElaRVJfRU5BQkxFRCkgJiYgIURJU0FCTEVfUkVBTFRJTUUKKyNpZiAh
ZGVmaW5lZChFQl9USFJFQURfU0FOSVRJWkVSX0VOQUJMRUQpICYmICFESVNBQkxFX1JFQUxUSU1F
ICYmICFkZWZpbmVkKF9fQU5EUk9JRF9fKQogICAgIHB0aHJlYWRfYXR0cl90IGF0dHI7CiAgICAg
cHRocmVhZF9hdHRyX2luaXQoJmF0dHIpOwogICAgIHB0aHJlYWRfYXR0cl9zZXRzY2hlZHBvbGlj
eSgmYXR0ciwgU0NIRURfRklGTyk7CgotLS0gU291cmNlL0xpYi9Db21tb24vQ29kZWMvRWJUaHJl
YWRzLmgJMjAyMS0xMC0zMCAxNzozMDo1MS41ODUwNDYzMDAgKzAxMDAKKysrIFNvdXJjZS9MaWIv
Q29tbW9uL0NvZGVjL0ViVGhyZWFkcy5oCTIwMjEtMTAtMzAgMTc6MzA6MzIuODcxMDAwMDAwICsw
MTAwCkBAIC04MSw3ICs4MSw3IEBACiAjZW5kaWYKICNpbmNsdWRlIDxzY2hlZC5oPgogI2luY2x1
ZGUgPHB0aHJlYWQuaD4KLSNpZiBkZWZpbmVkKF9fbGludXhfXykKKyNpZiBkZWZpbmVkKF9fbGlu
dXhfXykgJiYgIWRlZmluZWQoX19BTkRST0lEX18pCiAjZGVmaW5lIEVCX0NSRUFURV9USFJFQUQo
cG9pbnRlciwgdGhyZWFkX2Z1bmN0aW9uLCB0aHJlYWRfY29udGV4dCkgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCiAgICAgZG8geyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAg
ICAgIHBvaW50ZXIgPSBzdnRfY3JlYXRlX3RocmVhZCh0aHJlYWRfZnVuY3Rpb24sIHRocmVhZF9j
b250ZXh0KTsgICAgICAgICAgICAgICAgICAgICAgICBcCgotLS0gQ01ha2VMaXN0cy50eHQJMjAy
MS0xMC0zMCAxNzoyODo1Ny45NDUwNDYzMDAgKzAxMDAKKysrIENNYWtlTGlzdHMudHh0CTIwMjEt
MTAtMzAgMTc6Mjg6NDUuNjAwMDAwMDAwICswMTAwCkBAIC0yMDEsNyArMjAxLDkgQEAKICAgICBl
bHNlKCkKICAgICAgICAgY2hlY2tfYm90aF9mbGFnc19hZGQoLWZzdGFjay1wcm90ZWN0b3Itc3Ry
b25nKQogICAgIGVuZGlmKCkKLSAgICBjaGVja19ib3RoX2ZsYWdzX2FkZCgtbW5vLWF2eCkKKyAg
ICBpZiAoTk9UIENNQUtFX0NfQ09NUElMRVJfSUQgU1RSRVFVQUwgIkNsYW5nIikKKyAgICAgICAg
Y2hlY2tfYm90aF9mbGFnc19hZGQoLW1uby1hdngpCisgICAgZW5kaWYoKQogZW5kaWYoKQogCiBp
ZihDTUFLRV9DX0ZMQUdTIE1BVENIRVMgIi1PIiBBTkQgTk9UIENNQUtFX0NfRkxBR1MgTUFUQ0hF
UyAiLU8wIiBBTkQgTk9UIE1JTkdXKQ==
XB64_PATCH


# Filelist
# --------
# include/svt-av1/EbDebugMacros.h
# include/svt-av1/EbSvtAv1Formats.h
# include/svt-av1/EbSvtAv1ExtFrameBuf.h
# include/svt-av1/EbSvtAv1Enc.h
# include/svt-av1/EbSvtAv1ErrorCodes.h
# include/svt-av1/EbSvtAv1Metadata.h
# include/svt-av1/EbSvtAv1.h
# include/svt-av1/EbSvtAv1Dec.h
# lib/pkgconfig/SvtAv1Enc.pc
# lib/pkgconfig/SvtAv1Dec.pc
# lib/libSvtAv1Dec.so
# lib/libSvtAv1Enc.so
# bin/SvtAv1DecApp
# bin/SvtAv1EncApp
