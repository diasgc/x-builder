#!/bin/bash

lib='cpu_features'
dsc='A cross platform C99 library to get cpu features at runtime'
lic='Apache-2.0'
src='https://github.com/google/cpu_features.git'
cfg='cmake'
pkg='cpu_features'
pc_llib='-lcpufeatures'

cmake_bin='BUILD_STATIC_LIBS'
cmake_cfg='-DBUILD_GMOCK=OFF -DBUILD_TESTING=OFF -DINSTALL_GTEST=OFF'

lst_inc='ndk_compat/cpu-features.h cpu_features/*.h'
lst_lib='libcpu_features libndk_compat'
lst_bin='list_cpu_features'
lst_lic='LICENSE'
lst_pc='cpu_features.pc'

dev_bra='master'
dev_vrs=''
stb_bra=''
stb_vrs=''

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# patch 01-02: dual static shared build (cpu_features ndk_compat)
<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMub2xkCTIwMjItMDEtMjIgMjI6MzA6NDQuNjMzMDAwMDAwICswMDAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIyLTAxLTIyIDIyOjM1OjQxLjQ5NjQwMjMwMCArMDAwMApAQCAt
MTI4LDYgKzEyOCw3IEBACiBpZihOT1QgUFJPQ0VTU09SX0lTX1g4NiBBTkQgVU5JWCkKICAgbGlz
dChBUFBFTkQgQ1BVX0ZFQVRVUkVTX1NSQ1MgJDxUQVJHRVRfT0JKRUNUUzp1bml4X2Jhc2VkX2hh
cmR3YXJlX2RldGVjdGlvbj4pCiBlbmRpZigpCitzZXQoY3B1X2ZlYXR1cmVzX1RhcmdldCBjcHVf
ZmVhdHVyZXMpCiBhZGRfbGlicmFyeShjcHVfZmVhdHVyZXMgJHtDUFVfRkVBVFVSRVNfSERSU30g
JHtDUFVfRkVBVFVSRVNfU1JDU30pCiBzZXRfdGFyZ2V0X3Byb3BlcnRpZXMoY3B1X2ZlYXR1cmVz
IFBST1BFUlRJRVMgUFVCTElDX0hFQURFUiAiJHtDUFVfRkVBVFVSRVNfSERSU30iKQogc2V0dXBf
aW5jbHVkZV9hbmRfZGVmaW5pdGlvbnMoY3B1X2ZlYXR1cmVzKQpAQCAtMTQxLDcgKzE0MiwyMiBA
QAogICBlbmRpZigpCiBlbmRpZigpCiBhZGRfbGlicmFyeShDcHVGZWF0dXJlOjpjcHVfZmVhdHVy
ZXMgQUxJQVMgY3B1X2ZlYXR1cmVzKQotCitpZihCVUlMRF9TSEFSRURfTElCUyBBTkQgQlVJTERf
U1RBVElDX0xJQlMpCisgIHNldChjcHVfZmVhdHVyZXNfVGFyZ2V0IGNwdV9mZWF0dXJlcyBjcHVf
ZmVhdHVyZXNfc3RhdGljKQorICBhZGRfbGlicmFyeShjcHVfZmVhdHVyZXNfc3RhdGljIFNUQVRJ
QyAke0NQVV9GRUFUVVJFU19IRFJTfSAke0NQVV9GRUFUVVJFU19TUkNTfSkKKyAgc2V0X3Rhcmdl
dF9wcm9wZXJ0aWVzKGNwdV9mZWF0dXJlc19zdGF0aWMgUFJPUEVSVElFUyBQVUJMSUNfSEVBREVS
ICIke0NQVV9GRUFUVVJFU19IRFJTfSIpCisgIHNldF90YXJnZXRfcHJvcGVydGllcyhjcHVfZmVh
dHVyZXNfc3RhdGljIFBST1BFUlRJRVMgT1VUUFVUX05BTUUgY3B1X2ZlYXR1cmVzKQorICBzZXR1
cF9pbmNsdWRlX2FuZF9kZWZpbml0aW9ucyhjcHVfZmVhdHVyZXNfc3RhdGljKQorICB0YXJnZXRf
bGlua19saWJyYXJpZXMoY3B1X2ZlYXR1cmVzX3N0YXRpYyBQVUJMSUMgJHtDTUFLRV9ETF9MSUJT
fSkKKyAgdGFyZ2V0X2luY2x1ZGVfZGlyZWN0b3JpZXMoY3B1X2ZlYXR1cmVzX3N0YXRpYworICAg
IFBVQkxJQyAkPElOU1RBTExfSU5URVJGQUNFOiR7Q01BS0VfSU5TVEFMTF9JTkNMVURFRElSfS9j
cHVfZmVhdHVyZXM+CisgICkKKyAgaWYoUFJPQ0VTU09SX0lTX1g4NikKKyAgICBpZihBUFBMRSkK
KyAgICAgIHRhcmdldF9jb21waWxlX2RlZmluaXRpb25zKGNwdV9mZWF0dXJlcyBQUklWQVRFIEhB
VkVfU1lTQ1RMQllOQU1FKQorICAgIGVuZGlmKEFQUExFKQorICBlbmRpZihQUk9DRVNTT1JfSVNf
WDg2KQorZW5kaWYoQlVJTERfU0hBUkVEX0xJQlMgQU5EIEJVSUxEX1NUQVRJQ19MSUJTKQogIwog
IyBwcm9ncmFtIDogbGlzdF9jcHVfZmVhdHVyZXMKICMKQEAgLTIxNiw3ICsyMzIsNyBAQAogIwog
CiBpbmNsdWRlKEdOVUluc3RhbGxEaXJzKQotaW5zdGFsbChUQVJHRVRTIGNwdV9mZWF0dXJlcyBs
aXN0X2NwdV9mZWF0dXJlcworaW5zdGFsbChUQVJHRVRTICR7Y3B1X2ZlYXR1cmVzX1RhcmdldH0g
bGlzdF9jcHVfZmVhdHVyZXMKICAgRVhQT1JUIENwdUZlYXR1cmVzVGFyZ2V0cwogICBQVUJMSUNf
SEVBREVSIERFU1RJTkFUSU9OICR7Q01BS0VfSU5TVEFMTF9JTkNMVURFRElSfS9jcHVfZmVhdHVy
ZXMKICAgQVJDSElWRSBERVNUSU5BVElPTiAke0NNQUtFX0lOU1RBTExfTElCRElSfQoKLS0tIG5k
a19jb21wYXQvQ01ha2VMaXN0cy5vbGQJMjAyMi0wMS0yMiAyMjo0MzoxNC4wODQwMDAwMDAgKzAw
MDAKKysrIG5ka19jb21wYXQvQ01ha2VMaXN0cy50eHQJMjAyMi0wMS0yMiAyMjo0OToyMS4xMTY0
MDIzMDAgKzAwMDAKQEAgLTEyLDE2ICsxMiwyNCBAQAogIyBOb3RlIHRoYXQgZm9sbG93aW5nIGBh
ZGRfY3B1X2ZlYXR1cmVzX2hlYWRlcnNfYW5kX3NvdXJjZXNgIHdpbGwgdXNlCiAjIE5ES19DT01Q
QVRfU1JDUyBpbiBsaWV1IG9mIE5ES19DT01QQVRfSERSUyBiZWNhdXNlIHdlIGRvbid0IHdhbnQg
Y3B1X2ZlYXR1cmVzCiAjIGhlYWRlcnMgdG8gYmUgaW5zdGFsbGVkIGFsb25nc2lkZSBuZGtfY29t
cGF0Lgorc2V0KG5ka19jb21wYXRfVGFyZ2V0cyBuZGtfY29tcGF0KQogYWRkX2NwdV9mZWF0dXJl
c19oZWFkZXJzX2FuZF9zb3VyY2VzKE5ES19DT01QQVRfU1JDUyBOREtfQ09NUEFUX1NSQ1MpCiBh
ZGRfbGlicmFyeShuZGtfY29tcGF0ICR7TkRLX0NPTVBBVF9IRFJTfSAke05ES19DT01QQVRfU1JD
U30pCiBzZXR1cF9pbmNsdWRlX2FuZF9kZWZpbml0aW9ucyhuZGtfY29tcGF0KQogdGFyZ2V0X2lu
Y2x1ZGVfZGlyZWN0b3JpZXMobmRrX2NvbXBhdCBQVUJMSUMgJDxCVUlMRF9JTlRFUkZBQ0U6JHtD
TUFLRV9DVVJSRU5UX1NPVVJDRV9ESVJ9PikKIHRhcmdldF9saW5rX2xpYnJhcmllcyhuZGtfY29t
cGF0IFBVQkxJQyAke0NNQUtFX0RMX0xJQlN9ICR7Q01BS0VfVEhSRUFEX0xJQlNfSU5JVH0pCiBz
ZXRfdGFyZ2V0X3Byb3BlcnRpZXMobmRrX2NvbXBhdCBQUk9QRVJUSUVTIFBVQkxJQ19IRUFERVIg
IiR7TkRLX0NPTVBBVF9IRFJTfSIpCi0KK2lmKEJVSUxEX1NIQVJFRF9MSUJTIEFORCBCVUlMRF9T
VEFUSUNfTElCUykKKyAgYWRkX2xpYnJhcnkobmRrX2NvbXBhdF9zdGF0aWMgU1RBVElDICR7TkRL
X0NPTVBBVF9IRFJTfSAke05ES19DT01QQVRfU1JDU30pCisgIHNldHVwX2luY2x1ZGVfYW5kX2Rl
ZmluaXRpb25zKG5ka19jb21wYXRfc3RhdGljKQorICB0YXJnZXRfaW5jbHVkZV9kaXJlY3Rvcmll
cyhuZGtfY29tcGF0X3N0YXRpYyBQVUJMSUMgJDxCVUlMRF9JTlRFUkZBQ0U6JHtDTUFLRV9DVVJS
RU5UX1NPVVJDRV9ESVJ9PikKKyAgdGFyZ2V0X2xpbmtfbGlicmFyaWVzKG5ka19jb21wYXRfc3Rh
dGljIFBVQkxJQyAke0NNQUtFX0RMX0xJQlN9ICR7Q01BS0VfVEhSRUFEX0xJQlNfSU5JVH0pCisg
IHNldF90YXJnZXRfcHJvcGVydGllcyhuZGtfY29tcGF0X3N0YXRpYyBQUk9QRVJUSUVTIFBVQkxJ
Q19IRUFERVIgIiR7TkRLX0NPTVBBVF9IRFJTfSIpCisgIHNldF90YXJnZXRfcHJvcGVydGllcyhu
ZGtfY29tcGF0X3N0YXRpYyBQUk9QRVJUSUVTIE9VVFBVVF9OQU1FIG5ka19jb21wYXQpCisgIHNl
dChuZGtfY29tcGF0X1RhcmdldHMgbmRrX2NvbXBhdCBuZGtfY29tcGF0X3N0YXRpYykKK2VuZGlm
KCkKIGluY2x1ZGUoR05VSW5zdGFsbERpcnMpCi1pbnN0YWxsKFRBUkdFVFMgbmRrX2NvbXBhdAot
ICBFWFBPUlQgQ3B1RmVhdHVyZXNOZGtDb21wYXRUYXJnZXRzCitpbnN0YWxsKFRBUkdFVFMgJHtu
ZGtfY29tcGF0X1RhcmdldHN9IEVYUE9SVCBDcHVGZWF0dXJlc05ka0NvbXBhdFRhcmdldHMKICAg
UFVCTElDX0hFQURFUiBERVNUSU5BVElPTiAke0NNQUtFX0lOU1RBTExfSU5DTFVERURJUn0vbmRr
X2NvbXBhdAogICBBUkNISVZFIERFU1RJTkFUSU9OICR7Q01BS0VfSU5TVEFMTF9MSUJESVJ9CiAg
IExJQlJBUlkgREVTVElOQVRJT04gJHtDTUFLRV9JTlNUQUxMX0xJQkRJUn0K
XB64_PATCH

# Filelist
# --------
# include/ndk_compat/cpu-features.h
# include/cpu_features/cpuinfo_aarch64.h
# include/cpu_features/cpu_features_cache_info.h
# include/cpu_features/cpu_features_macros.h
# lib/pkgconfig/cpu_features.pc
# lib/libcpu_features.so
# lib/libcpu_features.a
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatTargets.cmake
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatConfig.cmake
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatTargets-release.cmake
# lib/cmake/CpuFeaturesNdkCompat/CpuFeaturesNdkCompatConfigVersion.cmake
# lib/cmake/CpuFeatures/CpuFeaturesConfigVersion.cmake
# lib/cmake/CpuFeatures/CpuFeaturesTargets.cmake
# lib/cmake/CpuFeatures/CpuFeaturesConfig.cmake
# lib/cmake/CpuFeatures/CpuFeaturesTargets-release.cmake
# lib/libndk_compat.a
# lib/libndk_compat.so
# share/doc/cpu_features/LICENSE
# bin/list_cpu_features
