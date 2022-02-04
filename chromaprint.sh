#!/bin/bash

lib='chromaprint'
pkg='libchromaprint'
apt='libchromaprint1'
dsc='C library for generating audio fingerprints used by AcoustID'
src='https://github.com/acoustid/chromaprint.git'
lic='LGPL-2.1'
cfg='cmake'
eta='12'

mkc='clean'
mki='install/strip'
cmake_static="BUILD_STATIC_LIBS"

lst_inc='chromaprint.h'
lst_lib='libchromaprint'
lst_bin=''
lst_lic='LICENSE.md'
lst_pc='libchromaprint.pc'
# cb0="-DBUILD_TOOLS=OFF"
# cb1="-DBUILD_TOOLS=OFF" # disable bin: cannot build bin (requires FFMPEG_LIBXXXXX_INCLUDE_DIRS)

. xbuilder.sh

cmake_cfg="-DKISSFFT_SOURCE_DIR=${dir_src}/src/3rdparty/kissfft -DBUILD_TOOLS=OFF -DBUILD_TESTS=OFF"

start

# Patch 01: to build dual static and shared libs
# Patch 02-03: prefix relative paths in pc file
<<'XB64_PATCH'
LS0tIHNyYy9DTWFrZUxpc3RzLnR4XwkyMDIyLTAxLTIyIDAwOjQ3OjA4LjE2NTM3NzcwMCArMDAw
MAorKysgc3JjL0NNYWtlTGlzdHMudHh0CTIwMjItMDEtMjIgMDA6NDQ6MDUuOTc1Mzc3NzAwICsw
MDAwCkBAIC03Myw2ICs3Myw3IEBACiAJc2V0X3RhcmdldF9wcm9wZXJ0aWVzKGNocm9tYXByaW50
X29ianMgUFJPUEVSVElFUyBQT1NJVElPTl9JTkRFUEVOREVOVF9DT0RFIFRSVUUpCiBlbmRpZigp
CiAKK3NldChjaHJvbWFwcmludF9UQVJHRVRTIGNocm9tYXByaW50KQogYWRkX2xpYnJhcnkoY2hy
b21hcHJpbnQgJHtjaHJvbWFwcmludF9QVUJMSUNfU09VUkNFU30gJHtjaHJvbWFwcmludF9QVUJM
SUNfSEVBREVSU30gJDxUQVJHRVRfT0JKRUNUUzpjaHJvbWFwcmludF9vYmpzPikKIHNldF90YXJn
ZXRfcHJvcGVydGllcyhjaHJvbWFwcmludCBQUk9QRVJUSUVTCiAJREVGSU5FX1NZTUJPTCBDSFJP
TUFQUklOVF9BUElfRVhQT1JUUwpAQCAtODAsMTIgKzgxLDIzIEBACiAgICAgVkVSU0lPTiAke2No
cm9tYXByaW50X1ZFUlNJT059CiAgICAgU09WRVJTSU9OICR7Y2hyb21hcHJpbnRfU09WRVJTSU9O
fQogKQoraWYoQlVJTERfU0hBUkVEX0xJQlMgQU5EIEJVSUxEX1NUQVRJQ19MSUJTKQorCWFkZF9s
aWJyYXJ5KGNocm9tYXByaW50X3N0YXRpYyBTVEFUSUMgJHtjaHJvbWFwcmludF9QVUJMSUNfU09V
UkNFU30gJHtjaHJvbWFwcmludF9QVUJMSUNfSEVBREVSU30gJDxUQVJHRVRfT0JKRUNUUzpjaHJv
bWFwcmludF9vYmpzPikKKwlzZXRfdGFyZ2V0X3Byb3BlcnRpZXMoY2hyb21hcHJpbnRfc3RhdGlj
IFBST1BFUlRJRVMKKwkJREVGSU5FX1NZTUJPTCBDSFJPTUFQUklOVF9BUElfRVhQT1JUUworCQlQ
VUJMSUNfSEVBREVSICR7Y2hyb21hcHJpbnRfUFVCTElDX0hFQURFUlN9CisJCVZFUlNJT04gJHtj
aHJvbWFwcmludF9WRVJTSU9OfQorCQlTT1ZFUlNJT04gJHtjaHJvbWFwcmludF9TT1ZFUlNJT059
CisJKQorCXNldF90YXJnZXRfcHJvcGVydGllcyhjaHJvbWFwcmludF9zdGF0aWMgUFJPUEVSVElF
UyBPVVRQVVRfTkFNRSBjaHJvbWFwcmludCkKKwlzZXQoY2hyb21hcHJpbnRfVEFSR0VUUyBjaHJv
bWFwcmludCBjaHJvbWFwcmludF9zdGF0aWMpCitlbmRpZigpCiBpZihCVUlMRF9GUkFNRVdPUksp
CiAJc2V0X3RhcmdldF9wcm9wZXJ0aWVzKGNocm9tYXByaW50IFBST1BFUlRJRVMgRlJBTUVXT1JL
IFRSVUUpCiBlbmRpZigpCiB0YXJnZXRfbGlua19saWJyYXJpZXMoY2hyb21hcHJpbnQgJHtjaHJv
bWFwcmludF9MSU5LX0xJQlN9KQogCi1pbnN0YWxsKFRBUkdFVFMgY2hyb21hcHJpbnQKK2luc3Rh
bGwoVEFSR0VUUyAke2Nocm9tYXByaW50X1RBUkdFVFN9CiAJRlJBTUVXT1JLIERFU1RJTkFUSU9O
ICR7RlJBTUVXT1JLX0lOU1RBTExfRElSfQogCUxJQlJBUlkgREVTVElOQVRJT04gJHtMSUJfSU5T
VEFMTF9ESVJ9CiAJUlVOVElNRSBERVNUSU5BVElPTiAke0JJTl9JTlNUQUxMX0RJUn0KLS0tIENN
YWtlTGlzdHMudHhfCTIwMjItMDEtMjIgMDE6MDY6MzUuMzM5MDAwMDAwICswMDAwCisrKyBDTWFr
ZUxpc3RzLnR4dAkyMDIyLTAxLTIyIDAxOjExOjQzLjk0NTM3NzcwMCArMDAwMApAQCAtMTkzLDcg
KzE5Myw3IEBACiBlbmRpZigpCiAKIGlmKE5PVCBCVUlMRF9GUkFNRVdPUkspCi0JY29uZmlndXJl
X2ZpbGUoJHtDTUFLRV9DVVJSRU5UX1NPVVJDRV9ESVJ9L2xpYmNocm9tYXByaW50LnBjLmNtYWtl
ICR7Q01BS0VfQ1VSUkVOVF9CSU5BUllfRElSfS9saWJjaHJvbWFwcmludC5wYykKKwljb25maWd1
cmVfZmlsZSgiJHtDTUFLRV9DVVJSRU5UX1NPVVJDRV9ESVJ9L2xpYmNocm9tYXByaW50LnBjLmNt
YWtlIiAiJHtDTUFLRV9DVVJSRU5UX0JJTkFSWV9ESVJ9L2xpYmNocm9tYXByaW50LnBjIiBAT05M
WSkKIAlpbnN0YWxsKAogICAgICAgICBGSUxFUyAke0NNQUtFX0NVUlJFTlRfQklOQVJZX0RJUn0v
bGliY2hyb21hcHJpbnQucGMKICAgICAgICAgREVTVElOQVRJT04gJHtMSUJfSU5TVEFMTF9ESVJ9
L3BrZ2NvbmZpZwoKLS0tIGxpYmNocm9tYXByaW50LnBjLmNtYWtfCTIwMjItMDEtMjIgMDA6NTg6
NDQuNTU1Mzc3NzAwICswMDAwCisrKyBsaWJjaHJvbWFwcmludC5wYy5jbWFrZQkyMDIyLTAxLTIy
IDAxOjEzOjE2LjY3NTM3NzcwMCArMDAwMApAQCAtMSwxMSArMSwxMiBAQAotcHJlZml4PSR7Q01B
S0VfSU5TVEFMTF9QUkVGSVh9Ci1leGVjX3ByZWZpeD0ke0VYRUNfSU5TVEFMTF9QUkVGSVh9Ci1s
aWJkaXI9JHtMSUJfSU5TVEFMTF9ESVJ9Ci1pbmNsdWRlZGlyPSR7SU5DTFVERV9JTlNUQUxMX0RJ
Un0KK3ByZWZpeD1AQ01BS0VfSU5TVEFMTF9QUkVGSVhACitleGVjX3ByZWZpeD1ARVhFQ19JTlNU
QUxMX1BSRUZJWEAKK2xpYmRpcj0ke3ByZWZpeH0vbGliCitpbmNsdWRlZGlyPSR7cHJlZml4fS9p
bmNsdWRlCiAKLU5hbWU6ICR7UFJPSkVDVF9OQU1FfQorTmFtZTogQFBST0pFQ1RfTkFNRUAKIERl
c2NyaXB0aW9uOiBBdWRpbyBmaW5nZXJwcmludCBsaWJyYXJ5CiBVUkw6IGh0dHA6Ly9hY291c3Rp
ZC5vcmcvY2hyb21hcHJpbnQKLVZlcnNpb246ICR7UFJPSkVDVF9WRVJTSU9OfQotTGliczogLUwk
e0xJQl9JTlNUQUxMX0RJUn0gLWxjaHJvbWFwcmludAotQ2ZsYWdzOiAtSSR7SU5DTFVERV9JTlNU
QUxMX0RJUn0KK1ZlcnNpb246IEBQUk9KRUNUX1ZFUlNJT05ACitMaWJzOiAtTCR7bGliZGlyfSAt
bGNocm9tYXByaW50CitDZmxhZ3M6IC1JJHtpbmNsdWRlZGlyfQorCg==
XB64_PATCH

# cpu av8 av7 x86 x64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc


# Filelist
# --------
# include/chromaprint.h
# lib/pkgconfig/libchromaprint.pc
# lib/libchromaprint.a
# lib/libchromaprint.so
# share/doc/chromaprint/LICENSE.md
