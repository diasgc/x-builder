#!/bin/bash

lib='highway'
pkg='libhwy'
dsc='Performance-portable, length-agnostic SIMD with runtime dispatch'
lic='Apache2.0'
src='https://github.com/google/highway.git'
cfg='cmake'
eta='10'
lcv='0.14.2'
cstk='BUILD_STATIC_LIBS'

CFG="-DBUILD_GMOCK=OFF -DBUILD_TESTING=OFF -DHWY_EXAMPLES_TESTS_INSTALL=ON"

lst_inc='hwy/*.h hwy/tests/*.h hwy/contrib/*.h hwy/*.h hwy/ops/*.h'
lst_lib='libhwy.* libhwy_test.* libhwy_contrib.*'
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc='libhwy.pc libhwy-test.pc libhwy-contrib.pc'

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# patch 01: CMakeLists.txt to support dual static + shared build
<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMub2xkCTIwMjItMDEtMjQgMTc6MjA6NDcuNDgxMDAwNzAwICswMDAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIyLTAxLTI0IDE3OjIzOjMxLjUyMTAwMDcwMCArMDAwMApAQCAt
MjQyLDYgKzI0Miw0MiBAQAogdGFyZ2V0X2luY2x1ZGVfZGlyZWN0b3JpZXMoaHd5X3Rlc3QgUFVC
TElDICR7Q01BS0VfQ1VSUkVOVF9MSVNUX0RJUn0pCiB0YXJnZXRfY29tcGlsZV9mZWF0dXJlcyho
d3lfdGVzdCBQVUJMSUMgY3h4X3N0ZF8xMSkKIAorc2V0KGh3eV90YXJnZXRzIGh3eSBod3lfY29u
dHJpYiBod3lfdGVzdCkKK2lmKEJVSUxEX1NUQVRJQ19MSUJTIEFORCBCVUlMRF9TSEFSRURfTElC
UykKKyAgYWRkX2xpYnJhcnkoaHd5X3N0YXRpYyBTVEFUSUMgJHtIV1lfU09VUkNFU30pCisgIHRh
cmdldF9jb21waWxlX2RlZmluaXRpb25zKGh3eV9zdGF0aWMgUFVCTElDICIke0RMTEVYUE9SVF9U
T19ERUZJTkV9IikKKyAgdGFyZ2V0X2NvbXBpbGVfb3B0aW9ucyhod3lfc3RhdGljIFBSSVZBVEUg
JHtIV1lfRkxBR1N9KQorICBzZXRfcHJvcGVydHkoVEFSR0VUIChod3lfc3RhdGljIFBST1BFUlRZ
IFBPU0lUSU9OX0lOREVQRU5ERU5UX0NPREUgT04pCisgIHNldF90YXJnZXRfcHJvcGVydGllcyho
d3lfc3RhdGljIFBST1BFUlRJRVMgVkVSU0lPTiAke0xJQlJBUllfVkVSU0lPTn0gU09WRVJTSU9O
ICR7TElCUkFSWV9TT1ZFUlNJT059KQorICBzZXRfdGFyZ2V0X3Byb3BlcnRpZXMoaHd5X3N0YXRp
YyBQUk9QRVJUSUVTIE9VVFBVVF9OQU1FIGh3eSkKKyAgdGFyZ2V0X2luY2x1ZGVfZGlyZWN0b3Jp
ZXMoaHd5X3N0YXRpYyBQVUJMSUMgJHtDTUFLRV9DVVJSRU5UX0xJU1RfRElSfSkKKyAgdGFyZ2V0
X2NvbXBpbGVfZmVhdHVyZXMoaHd5X3N0YXRpYyBQVUJMSUMgY3h4X3N0ZF8xMSkKKyAgc2V0X3Rh
cmdldF9wcm9wZXJ0aWVzKGh3eV9zdGF0aWMgUFJPUEVSVElFUworICBMSU5LX0RFUEVORFMgJHtD
TUFLRV9DVVJSRU5UX1NPVVJDRV9ESVJ9L2h3eS9od3kudmVyc2lvbikKKyAgaWYoVU5JWCkKKyAg
ICBzZXRfcHJvcGVydHkoVEFSR0VUIChod3lfc3RhdGljIEFQUEVORF9TVFJJTkcgUFJPUEVSVFkK
KyAgICAgIExJTktfRkxBR1MgIiAtV2wsLS12ZXJzaW9uLXNjcmlwdD0ke0NNQUtFX0NVUlJFTlRf
U09VUkNFX0RJUn0vaHd5L2h3eS52ZXJzaW9uIikKKyAgZW5kaWYoKQorICBhZGRfbGlicmFyeSho
d3lfY29udHJpYl9zdGF0aWMgU1RBVElDICR7SFdZX0NPTlRSSUJfU09VUkNFU30pCisgIHRhcmdl
dF9saW5rX2xpYnJhcmllcyhod3lfY29udHJpYl9zdGF0aWMgaHd5X3N0YXRpYykKKyAgdGFyZ2V0
X2NvbXBpbGVfb3B0aW9ucyhod3lfY29udHJpYl9zdGF0aWMgUFJJVkFURSAke0hXWV9GTEFHU30p
CisgIHNldF90YXJnZXRfcHJvcGVydGllcyhod3lfc3RhdGljIFBST1BFUlRJRVMgT1VUUFVUX05B
TUUgaHd5X2NvbnRyaWIpCisgIHNldF9wcm9wZXJ0eShUQVJHRVQgKGh3eV9jb250cmliX3N0YXRp
YyBQUk9QRVJUWSBQT1NJVElPTl9JTkRFUEVOREVOVF9DT0RFIE9OKQorICBzZXRfdGFyZ2V0X3By
b3BlcnRpZXMoaHd5X2NvbnRyaWJfc3RhdGljIFBST1BFUlRJRVMgVkVSU0lPTiAke0xJQlJBUllf
VkVSU0lPTn0gU09WRVJTSU9OICR7TElCUkFSWV9TT1ZFUlNJT059KQorICB0YXJnZXRfaW5jbHVk
ZV9kaXJlY3Rvcmllcyhod3lfY29udHJpYl9zdGF0aWMgUFVCTElDICR7Q01BS0VfQ1VSUkVOVF9M
SVNUX0RJUn0pCisgIHRhcmdldF9jb21waWxlX2ZlYXR1cmVzKGh3eV9jb250cmliX3N0YXRpYyBQ
VUJMSUMgY3h4X3N0ZF8xMSkKKworICBhZGRfbGlicmFyeShod3lfdGVzdF9zdGF0aWMgU1RBVElD
ICR7SFdZX1RFU1RfU09VUkNFU30pCisgIHNldF90YXJnZXRfcHJvcGVydGllcyhod3lfdGVzdF9z
dGF0aWMgUFJPUEVSVElFUyBPVVRQVVRfTkFNRSBod3lfdGVzdCkKKyAgdGFyZ2V0X2xpbmtfbGli
cmFyaWVzaCh3eV90ZXN0X3N0YXRpYyBod3lfc3RhdGljKQorICB0YXJnZXRfY29tcGlsZV9vcHRp
b25zKGh3eV90ZXN0X3N0YXRpYyBQUklWQVRFICR7SFdZX0ZMQUdTfSkKKyAgc2V0X3Byb3BlcnR5
KFRBUkdFVCBod3lfdGVzdF9zdGF0aWMgUFJPUEVSVFkgUE9TSVRJT05fSU5ERVBFTkRFTlRfQ09E
RSBPTikKKyAgc2V0X3RhcmdldF9wcm9wZXJ0aWVzKGh3eV90ZXN0X3N0YXRpYyBQUk9QRVJUSUVT
IFZFUlNJT04gJHtMSUJSQVJZX1ZFUlNJT059IFNPVkVSU0lPTiAke0xJQlJBUllfU09WRVJTSU9O
fSkKKyAgdGFyZ2V0X2luY2x1ZGVfZGlyZWN0b3JpZXMoaHd5X3Rlc3Rfc3RhdGljIFBVQkxJQyAk
e0NNQUtFX0NVUlJFTlRfTElTVF9ESVJ9KQorICB0YXJnZXRfY29tcGlsZV9mZWF0dXJlcyhod3lf
dGVzdF9zdGF0aWMgUFVCTElDIGN4eF9zdGRfMTEpCisgIGxpc3QoQVBQRU5EIGh3eV90YXJnZXRz
IGh3eV9zdGF0aWMgaHd5X2NvbnRyaWJfc3RhdGljIGh3eV90ZXN0X3N0YXRpYykKK2VuZGlmKCkK
KwogIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSBod3lfbGlzdF90YXJnZXRzCiAjIEdlbmVyYXRlIGEgdG9vbCB0byBwcmludCB0aGUgY29t
cGlsZWQtaW4gdGFyZ2V0cyBhcyBkZWZpbmVkIGJ5IHRoZSBjdXJyZW50CiAjIGZsYWdzLiBUaGlz
IHRvb2wgd2lsbCBwcmludCB0byBzdGRlcnIgYXQgYnVpbGQgdGltZSwgYWZ0ZXIgYnVpbGRpbmcg
aHd5LgpAQCAtMjY2LDcgKzMwMiw3IEBACiAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIGluc3RhbGwgbGlicmFyeQogaWYgKEhXWV9FTkFC
TEVfSU5TVEFMTCkKIAotaW5zdGFsbChUQVJHRVRTIGh3eQoraW5zdGFsbChUQVJHRVRTICR7aHd5
X3RhcmdldHN9CiAgIERFU1RJTkFUSU9OICIke0NNQUtFX0lOU1RBTExfTElCRElSfSIpCiAjIElu
c3RhbGwgYWxsIHRoZSBoZWFkZXJzIGtlZXBpbmcgdGhlIHJlbGF0aXZlIHBhdGggdG8gdGhlIGN1
cnJlbnQgZGlyZWN0b3J5CiAjIHdoZW4gaW5zdGFsbGluZyB0aGVtLgpAQCAtMjc4LDggKzMxNCw2
IEBACiAgIGVuZGlmKCkKIGVuZGZvcmVhY2goKQogCi1pbnN0YWxsKFRBUkdFVFMgaHd5X2NvbnRy
aWIKLSAgREVTVElOQVRJT04gIiR7Q01BS0VfSU5TVEFMTF9MSUJESVJ9IikKICMgSW5zdGFsbCBh
bGwgdGhlIGhlYWRlcnMga2VlcGluZyB0aGUgcmVsYXRpdmUgcGF0aCB0byB0aGUgY3VycmVudCBk
aXJlY3RvcnkKICMgd2hlbiBpbnN0YWxsaW5nIHRoZW0uCiBmb3JlYWNoIChzb3VyY2UgJHtIV1lf
Q09OVFJJQl9TT1VSQ0VTfSkKQEAgLTI5MCw4ICszMjQsNiBAQAogICBlbmRpZigpCiBlbmRmb3Jl
YWNoKCkKIAotaW5zdGFsbChUQVJHRVRTIGh3eV90ZXN0Ci0gIERFU1RJTkFUSU9OICIke0NNQUtF
X0lOU1RBTExfTElCRElSfSIpCiAjIEluc3RhbGwgYWxsIHRoZSBoZWFkZXJzIGtlZXBpbmcgdGhl
IHJlbGF0aXZlIHBhdGggdG8gdGhlIGN1cnJlbnQgZGlyZWN0b3J5CiAjIHdoZW4gaW5zdGFsbGlu
ZyB0aGVtLgogZm9yZWFjaCAoc291cmNlICR7SFdZX1RFU1RfU09VUkNFU30pCg==
XB64_PATCH

# Filelist
# --------
# include/hwy/nanobenchmark.h
# include/hwy/detect_targets.h
# include/hwy/detect_compiler_arch.h
# include/hwy/tests/test_util-inl.h
# include/hwy/tests/include_farm_sve.h
# include/hwy/tests/hwy_gtest.h
# include/hwy/tests/test_util.h
# include/hwy/contrib/sort/sort-inl.h
# include/hwy/contrib/image/image.h
# include/hwy/contrib/math/math-inl.h
# include/hwy/contrib/dot/dot-inl.h
# include/hwy/highway.h
# include/hwy/targets.h
# include/hwy/highway_export.h
# include/hwy/base.h
# include/hwy/aligned_allocator.h
# include/hwy/ops/x86_512-inl.h
# include/hwy/ops/arm_sve-inl.h
# include/hwy/ops/generic_ops-inl.h
# include/hwy/ops/arm_neon-inl.h
# include/hwy/ops/shared-inl.h
# include/hwy/ops/x86_128-inl.h
# include/hwy/ops/wasm_128-inl.h
# include/hwy/ops/x86_256-inl.h
# include/hwy/ops/set_macros-inl.h
# include/hwy/ops/scalar-inl.h
# include/hwy/cache_control.h
# include/hwy/foreach_target.h
# lib/libhwy_test.so
# lib/libhwy_test.a
# lib/pkgconfig/libhwy-test.pc
# lib/pkgconfig/libhwy.pc
# lib/pkgconfig/libhwy-contrib.pc
# lib/libhwy_contrib.so
# lib/libhwy_contrib.a
# lib/libhwy.so
# lib/libhwy.a
# share/doc/highway/LICENSE
