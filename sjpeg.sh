#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +F+ +F+ +F+ ... CLANG
# GNU +++ ... ... +F+ GCC
# WIN ... ... ... +.+ CLANG/GCC

lib='sjpeg'
dsc='SimpleJPEG: simple jpeg encoder'
lic='Apache2.0'
src='https://github.com/webmproject/sjpeg.git' src_opt="--recursive"
cfg='cmake'
eta='20'
dep='libjpeg libpng'
pc_llib='-lsjpeg'
lst_inc='sjpeg.h'
lst_lib='libsjpeg'
lst_bin='vjpeg sjpeg'

. xbuilder.sh

CFG="-DSJPEG_ANDROID_NDK_PATH=${ANDROID_NDK_HOME}"

start


<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMub2xkCTIwMjEtMTAtMTEgMjI6NDQ6MDUuMDQ3MDAwMDAwICswMTAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIxLTEwLTExIDIyOjU5OjAzLjMxMDAwMDAwMCArMDEwMApAQCAt
MjIsNiArMjIsNyBAQAogIyBPcHRpb25zIGZvciBjb2RlciAvIGRlY29kZXIgZXhlY3V0YWJsZXMu
CiBvcHRpb24oU0pQRUdfRU5BQkxFX1NJTUQgIkVuYWJsZSBhbnkgU0lNRCBvcHRpbWl6YXRpb24u
IiBPTikKIG9wdGlvbihTSlBFR19CVUlMRF9FWEFNUExFUyAiQnVpbGQgdGhlIHNqcGVnIC8gdmpw
ZWcgY29tbWFuZCBsaW5lIHRvb2xzLiIgT04pCitvcHRpb24oU0pQRUdfSU5TVEFMTF9NQU5QQUdF
ICJCdWlsZCBtYW4gcGFnZSIgT0ZGKQogCiBzZXQoU0pQRUdfREVQX0xJQlJBUklFUykKIHNldChT
SlBFR19ERVBfSU5DTFVERV9ESVJTKQpAQCAtMTI5LDYgKzEzMCw4IEBACiBpZihXSU4zMikKICAg
IyBxdWlldCB3YXJuaW5ncyByZWxhdGVkIHRvIGZvcGVuLCBzc2NhbmYKICAgdGFyZ2V0X2NvbXBp
bGVfZGVmaW5pdGlvbnModXRpbHMgUFJJVkFURSBfQ1JUX1NFQ1VSRV9OT19XQVJOSU5HUykKK2Vs
c2UoKQorICBzZXRfdGFyZ2V0X3Byb3BlcnRpZXModXRpbHMgUFJPUEVSVElFUyBQT1NJVElPTl9J
TkRFUEVOREVOVF9DT0RFIE9OKQogZW5kaWYoKQogaWYoU0pQRUdfSEFWRV9PUEVOR0wpCiAgICMg
Y2hlY2sgcHRocmVhZCBmb3IgR0wgbGlicmFyaWVzCkBAIC0xNTYsNyArMTU5LDcgQEAKICAgdGFy
Z2V0X2xpbmtfbGlicmFyaWVzKHV0aWxzICR7U0pQRUdfREVQX0lNR19MSUJSQVJJRVN9CiAgICAg
ICAgICAgICAgICAgICAgICAgICAke1NKUEVHX0RFUF9HTF9MSUJSQVJJRVN9KQogZW5kaWYoKQot
IyBzZXRfdGFyZ2V0X3Byb3BlcnRpZXModXRpbHMgUFJPUEVSVElFUyBQT1NJVElPTl9JTkRFUEVO
REVOVF9DT0RFIE9OKQorCiAKICMgQnVpbGQgdGhlIGV4ZWN1dGFibGVzIGlmIGFza2VkIGZvci4K
IGlmKFNKUEVHX0JVSUxEX0VYQU1QTEVTKQpAQCAtMjI2LDYgKzIyOSw4IEBACiAKICMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjCiAjIE1hbiBwYWdlLgoraWYoU0pQRUdfSU5TVEFMTF9NQU5QQUdFKQog
aW5zdGFsbChGSUxFUyAke0NNQUtFX0NVUlJFTlRfU09VUkNFX0RJUn0vbWFuL3NqcGVnLjEKICAg
ICAgICAgICAgICAgJHtDTUFLRV9DVVJSRU5UX1NPVVJDRV9ESVJ9L21hbi92anBlZy4xCiAgIERF
U1RJTkFUSU9OICR7Q01BS0VfSU5TVEFMTF9NQU5ESVJ9L21hbjEpCitlbmRpZigpCg==
XB64_PATCH

# Filelist
# --------
# include/sjpeg.h
# lib/pkgconfig/sjpeg.pc
# lib/libsjpeg.a
# share/sjpeg/cmake/sjpegConfigVersion.cmake
# share/sjpeg/cmake/sjpegConfig.cmake
# bin/vjpeg
# bin/sjpeg
