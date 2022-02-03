#!/bin/bash
# cpu  av8 av7 x86 x64  cc
# NDK  P+. P+.  .   .   clang
# GNU  P+.  .   .   .   gcc
# WIN  P+.  .   .  P++  clang

lib='libde265'
apt='libde265-dev'
dsc='Open h.265 video codec implementation.'
lic='LGPL-3.0'
src='https://github.com/strukturag/libde265.git'
cfg='cmake'
eta='140'
automake_cmd='./autogen.sh'

lst_inc='libde265/*.h'
lst_lib='liblibde265'
lst_bin='enc265 hdrcopy dec265'
lst_lic='COPYING AUTHORS'
lst_pc='libde265.pc'

dev_bra='main'
dev_vrs=''
stb_bra=''
stb_vrs=''

cmake_static='BUILD_STATIC_LIBS'
cmake_cfg='-DENABLE_SDL=OFF'

. xbuilder.sh

$host_arm && cmake_cfg+=' -DDISABLE_SSE=ON' || cmake_cfg+=' -DDISABLE_SSE=OFF'
case $cfg in
  #cmake) pc_llib='-lde265' pc_libsprivate='-lpthread -lstdc++';;
  ag)    $host_arm && ac_cfg+=" --disable-sse --disable-arm"
         $host_mingw && CSH=${CSH/"--disable-shared "} #see similar https://github.com/opencv/opencv/pull/9052
         ;;
esac

start

<<'XB64_PATCH'
LS0tIGxpYmRlMjY1L0NNYWtlTGlzdHMudHh0CTIwMjItMDItMDMgMDE6MjA6NDkuNTIwNDUxODAw
ICswMDAwCisrKyBsaWJkZTI2NS9DTWFrZUxpc3RzLnR4dAkyMDIyLTAyLTAzIDAxOjE1OjExLjM3
MDQ1MTgwMCArMDAwMApAQCAtODYsNiArODYsNyBAQAogCiBhZGRfZGVmaW5pdGlvbnMoLURMSUJE
RTI2NV9FWFBPUlRTKQogCithZGRfY29tcGlsZV9vcHRpb25zKC1Xbm8tdW51c2VkLXZhcmlhYmxl
IC1Xbm8tdW51c2VkLWJ1dC1zZXQtdmFyaWFibGUgLVduby11bnVzZWQtZnVuY3Rpb24gLVduby11
bmluaXRpYWxpemVkKQogYWRkX3N1YmRpcmVjdG9yeSAoZW5jb2RlcikKIAogaWYoTk9UIERJU0FC
TEVfU1NFKQpAQCAtMTEwLDE4ICsxMTEsMjcgQEAKIGFkZF9saWJyYXJ5KCR7UFJPSkVDVF9OQU1F
fSAke2xpYmRlMjY1X3NvdXJjZXN9ICR7RU5DT0RFUl9PQkpFQ1RTfSAke1g4Nl9PQkpFQ1RTfSkK
IHRhcmdldF9saW5rX2xpYnJhcmllcygke1BST0pFQ1RfTkFNRX0gUFJJVkFURSBUaHJlYWRzOjpU
aHJlYWRzKQogCitzZXQobGliZGUyNjVfdGFyZ2V0cyAke1BST0pFQ1RfTkFNRX0pCitpZihCVUlM
RF9TSEFSRURfTElCUyBBTkQgQlVJTERfU1RBVElDX0xJQlMpCisgIGFkZF9saWJyYXJ5KCR7UFJP
SkVDVF9OQU1FfS1zdGF0aWMgU1RBVElDICR7bGliZGUyNjVfc291cmNlc30gJHtFTkNPREVSX09C
SkVDVFN9ICR7WDg2X09CSkVDVFN9KQorICB0YXJnZXRfY29tcGlsZV9kZWZpbml0aW9ucygke1BS
T0pFQ1RfTkFNRX0tc3RhdGljIFBSSVZBVEUgTElCREUyNjVfU1RBVElDX0JVSUxEKQorICB0YXJn
ZXRfbGlua19saWJyYXJpZXMoJHtQUk9KRUNUX05BTUV9LXN0YXRpYyBQUklWQVRFIFRocmVhZHM6
OlRocmVhZHMpCisgIHNldF90YXJnZXRfcHJvcGVydGllcygke1BST0pFQ1RfTkFNRX0tc3RhdGlj
IFBST1BFUlRJRVMgT1VUUFVUX05BTUUgJHtQUk9KRUNUX05BTUV9KQorICBsaXN0KEFQUEVORCBs
aWJkZTI2NV90YXJnZXRzICR7UFJPSkVDVF9OQU1FfS1zdGF0aWMpCitlbmRpZigpCiB3cml0ZV9i
YXNpY19wYWNrYWdlX3ZlcnNpb25fZmlsZSgke1BST0pFQ1RfTkFNRX1Db25maWdWZXJzaW9uLmNt
YWtlIENPTVBBVElCSUxJVFkgRXhhY3RWZXJzaW9uKQogCi1pbnN0YWxsKFRBUkdFVFMgJHtQUk9K
RUNUX05BTUV9IEVYUE9SVCAke1BST0pFQ1RfTkFNRX1Db25maWcKK2luc3RhbGwoVEFSR0VUUyAk
e2xpYmRlMjY1X3RhcmdldHN9IEVYUE9SVCAke1BST0pFQ1RfTkFNRX1Db25maWcKICAgICBSVU5U
SU1FIERFU1RJTkFUSU9OICR7Q01BS0VfSU5TVEFMTF9CSU5ESVJ9CiAgICAgTElCUkFSWSBERVNU
SU5BVElPTiAke0NNQUtFX0lOU1RBTExfTElCRElSfQogICAgIEFSQ0hJVkUgREVTVElOQVRJT04g
JHtDTUFLRV9JTlNUQUxMX0xJQkRJUn0KICkKIAogaW5zdGFsbChGSUxFUyAke2xpYmRlMjY1X2hl
YWRlcnN9IERFU1RJTkFUSU9OICR7Q01BS0VfSU5TVEFMTF9JTkNMVURFRElSfS8ke1BST0pFQ1Rf
TkFNRX0pCi1pbnN0YWxsKEZJTEVTICR7Q01BS0VfQ1VSUkVOVF9CSU5BUllfRElSfS9kZTI2NS12
ZXJzaW9uLmggREVTVElOQVRJT04gJHtDTUFLRV9JTlNUQUxMX0lOQ0xVREVESVJ9LyR7UFJPSkVD
VF9OQU1FfSkKK2luc3RhbGwoRklMRVMgJHtDTUFLRV9TT1VSQ0VfRElSfS9saWJkZTI2NS9kZTI2
NS12ZXJzaW9uLmggREVTVElOQVRJT04gJHtDTUFLRV9JTlNUQUxMX0lOQ0xVREVESVJ9LyR7UFJP
SkVDVF9OQU1FfSkKIAogaW5zdGFsbChFWFBPUlQgJHtQUk9KRUNUX05BTUV9Q29uZmlnIERFU1RJ
TkFUSU9OICIke0NNQUtFX0lOU1RBTExfTElCRElSfS9jbWFrZS8ke1BST0pFQ1RfTkFNRX0iKQog
CiBpbnN0YWxsKEZJTEVTICR7Q01BS0VfQ1VSUkVOVF9CSU5BUllfRElSfS8ke1BST0pFQ1RfTkFN
RX1Db25maWdWZXJzaW9uLmNtYWtlIERFU1RJTkFUSU9OCi0gICAgIiR7Q01BS0VfSU5TVEFMTF9M
SUJESVJ9L2NtYWtlLyR7UFJPSkVDVF9OQU1FfSIpClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmls
ZQorICAgICIke0NNQUtFX0lOU1RBTExfTElCRElSfS9jbWFrZS8ke1BST0pFQ1RfTkFNRX0iKQor
aW5zdGFsbChGSUxFUyAke0NNQUtFX1NPVVJDRV9ESVJ9L2xpYmRlMjY1LnBjIERFU1RJTkFUSU9O
IGxpYi9wa2djb25maWcpCgotLS0gQ01ha2VMaXN0cy50eHQJMjAyMi0wMi0wMyAwMToyMDowOS4y
MjA0NTE4MDAgKzAwMDAKKysrIENNYWtlTGlzdHMudHh0CTIwMjItMDItMDMgMDE6MjI6NDMuMDQw
NDUxODAwICswMDAwCkBAIC00Niw3ICs0NiwxNSBAQAogICBhZGRfZGVmaW5pdGlvbnMoLURIQVZF
X1BPU0lYX01FTUFMSUdOKQogZW5kaWYoKQogCi1jb25maWd1cmVfZmlsZSAobGliZGUyNjUvZGUy
NjUtdmVyc2lvbi5oLmluIGxpYmRlMjY1L2RlMjY1LXZlcnNpb24uaCkKK2NvbmZpZ3VyZV9maWxl
KGxpYmRlMjY1L2RlMjY1LXZlcnNpb24uaC5pbiAke0NNQUtFX1NPVVJDRV9ESVJ9L2xpYmRlMjY1
L2RlMjY1LXZlcnNpb24uaCkKKworc2V0KFZFUlNJT04gJHtQUk9KRUNUX1ZFUlNJT059KQorc2V0
KHByZWZpeCAke0NNQUtFX0lOU1RBTExfUFJFRklYfSkKK3NldChleGVjX3ByZWZpeCAiXCR7cHJl
Zml4fSIpCitzZXQobGliZGlyICJcJHtwcmVmaXh9L2xpYiIpCitzZXQoTElCUyAiLWxwdGhyZWFk
IC1sbSIpCitzZXQoaW5jbHVkZWRpciAiXCR7cHJlZml4fS9pbmNsdWRlIikKK2NvbmZpZ3VyZV9m
aWxlKGxpYmRlMjY1LnBjLmluICR7Q01BS0VfU09VUkNFX0RJUn0vbGliZGUyNjUucGMgQE9OTFkp
CiAKIGlmKENNQUtFX0NPTVBJTEVSX0lTX0dOVUNYWCBPUiAke0NNQUtFX0NYWF9DT01QSUxFUl9J
RH0gTUFUQ0hFUyBDbGFuZykKICAgYWRkX2RlZmluaXRpb25zKC1XYWxsKQpAQCAtNTUsOSArNjMs
NiBAQAogb3B0aW9uKERJU0FCTEVfU1NFICJEaXNhYmxlIFNTRSBvcHRpbWl6YXRpb25zIiBPRkYp
CiAKIG9wdGlvbihCVUlMRF9TSEFSRURfTElCUyAiQnVpbGQgc2hhcmVkIGxpYnJhcnkiIE9OKQot
aWYoTk9UIEJVSUxEX1NIQVJFRF9MSUJTKQotICBhZGRfZGVmaW5pdGlvbnMoLURMSUJERTI2NV9T
VEFUSUNfQlVJTEQpCi1lbmRpZigpCiAKIGluY2x1ZGVfZGlyZWN0b3JpZXMgKCIke1BST0pFQ1Rf
U09VUkNFX0RJUn0iKQogaW5jbHVkZV9kaXJlY3RvcmllcyAoIiR7UFJPSkVDVF9CSU5BUllfRElS
fSIpCg==
XB64_PATCH

# Filelist
# --------
# include/libde265/motion.h
# include/libde265/fallback-dct.h
# include/libde265/cabac.h
# include/libde265/deblock.h
# include/libde265/pps.h
# include/libde265/en265.h
# include/libde265/fallback-motion.h
# include/libde265/sei.h
# include/libde265/fallback.h
# include/libde265/image-io.h
# include/libde265/scan.h
# include/libde265/threads.h
# include/libde265/contextmodel.h
# include/libde265/transform.h
# include/libde265/bitstream.h
# include/libde265/sps.h
# include/libde265/vps.h
# include/libde265/slice.h
# include/libde265/md5.h
# include/libde265/alloc_pool.h
# include/libde265/image.h
# include/libde265/sao.h
# include/libde265/vui.h
# include/libde265/decctx.h
# include/libde265/refpic.h
# include/libde265/de265.h
# include/libde265/configparam.h
# include/libde265/quality.h
# include/libde265/de265-version.h
# include/libde265/nal.h
# include/libde265/nal-parser.h
# include/libde265/intrapred.h
# include/libde265/visualize.h
# include/libde265/acceleration.h
# include/libde265/dpb.h
# include/libde265/util.h
# lib/pkgconfig/libde265.pc
# lib/cmake/libde265/libde265ConfigVersion.cmake
# lib/cmake/libde265/libde265Config-release.cmake
# lib/cmake/libde265/libde265Config.cmake
# lib/liblibde265.so
# lib/liblibde265.a
# share/doc/libde265/AUTHORS
# share/doc/libde265/COPYING
# bin/enc265
# bin/hdrcopy
# bin/dec265
