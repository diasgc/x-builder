#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++  .  +++ clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='liblzf'
apt='liblzf1'
dsc='General purpose data compression library'
lic='BSD-2c'
vrs='3.6'
src="http://dist.schmorp.de/liblzf/liblzf-${vrs}.tar.gz"
cfg='cmake'
cbk='BUILD_UTILITIES'
eta='10'

pc_llib="-llzf"
pc_url="http://oldhome.schmorp.de/marc/liblzf.html"

lst_inc='lzf.h'
lst_lib='liblzf.*'
lst_bin='lzf'
lst_lic='LICENSE'

. xbuilder.sh

start

# Patch to generate config.h and CMakeLists.txt
# Patch lzfP.h
<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMudHh0CTIwMjItMDEtMTggMTc6Mjk6MDEuNzc2Nzk5NTAwICswMDAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIyLTAxLTE4IDE3OjI3OjQyLjMyNjc5OTUwMCArMDAwMApAQCAt
MCwwICsxLDU1IEBACitjbWFrZV9taW5pbXVtX3JlcXVpcmVkKFZFUlNJT04gMi44LjEyKQorCitw
cm9qZWN0KGx6ZiBDKQorCitvcHRpb24oQlVJTERfU1RBVElDX0xJQlMgIkJ1aWxkIHN0YXRpYyBs
aWJzIiBPTikKK29wdGlvbihCVUlMRF9VVElMSVRJRVMgIkJ1aWxkIHV0aWxpdGllcyIgT0ZGKQor
b3B0aW9uKElOU1RBTExfRE9DUyAiSW5zdGFsbCBkb2NzIiBPTikKKworc2V0KExJQk1BSk9SIDMp
CitzZXQoTElCTUlOT1IgNikKK3NldChMSUJQT0lOVCAwKQorc2V0KExJQlZFUiAiJHtMSUJNQUpP
Un0uJHtMSUJNSU5PUn0uJHtMSUJQT0lOVH0iKQorCitzZXQoc3JjX2xpYiBsemZfYy5jIGx6Zl9k
LmMgbHpmUC5oKQorc2V0KHNyYyBsemZfYy5jIGx6Zl9kLmMgbHpmLmMpCitzZXQoaGRyIGx6Zi5o
IGx6ZlAuaCBjcmMzMi5oKQorc2V0KGRvY3MgUkVBRE1FIExJQ0VOQ0UgQ2hhbmdlcykKKworYWRk
X2xpYnJhcnkobHpmICR7c3JjX2xpYn0pCitzZXRfdGFyZ2V0X3Byb3BlcnRpZXMobHpmIFBST1BF
UlRJRVMgVkVSU0lPTiAke0xJQlZFUn0gU09WRVJTSU9OICR7TElCTUFKT1J9KQorYWRkX2NvbXBp
bGVfb3B0aW9ucygiLVduby1leHBhbnNpb24tdG8tZGVmaW5lZCIpCisKK2lmKFdJTjMyKQorICBz
ZXRfdGFyZ2V0X3Byb3BlcnRpZXMobHpmIFBST1BFUlRJRVMgU1VGRklYICItJHtMSUJNQUpPUn0k
e0NNQUtFX1NIQVJFRF9MSUJSQVJZX1NVRkZJWH0iKQorZW5kaWYoV0lOMzIpCisKK2lmKEJVSUxE
X1NIQVJFRF9MSUJTIEFORCBCVUlMRF9TVEFUSUNfTElCUykKKyAgYWRkX2xpYnJhcnkobHpmX3N0
YXRpYyBTVEFUSUMgJHtzcmNfbGlifSkKKyAgc2V0X3RhcmdldF9wcm9wZXJ0aWVzKGx6Zl9zdGF0
aWMgUFJPUEVSVElFUyBPVVRQVVRfTkFNRSBsemYpCitlbmRpZigpCisKK2lmKEJVSUxEX1VUSUxJ
VElFUykKKyAgYWRkX2V4ZWN1dGFibGUobHpmX2JpbiBsemYuYyBsemYuaCkKKyAgdGFyZ2V0X2xp
bmtfbGlicmFyaWVzKGx6Zl9iaW4gbHpmKQorICBzZXRfdGFyZ2V0X3Byb3BlcnRpZXMobHpmX2Jp
biBQUk9QRVJUSUVTIE9VVFBVVF9OQU1FIGx6ZikKK2VuZGlmKCkKKworaW5zdGFsbChUQVJHRVRT
IGx6ZgorICAgIFJVTlRJTUUgREVTVElOQVRJT04gYmluCisgICAgQVJDSElWRSBERVNUSU5BVElP
TiBsaWIke0xJQl9TVUZGSVh9CisgICAgTElCUkFSWSBERVNUSU5BVElPTiBsaWIke0xJQl9TVUZG
SVh9KQorCitpZihCVUlMRF9TSEFSRURfTElCUyBBTkQgQlVJTERfU1RBVElDX0xJQlMpCisgIGlu
c3RhbGwoVEFSR0VUUyBsemZfc3RhdGljIEFSQ0hJVkUgREVTVElOQVRJT04gbGliJHtMSUJfU1VG
RklYfSkKK2VuZGlmKCkKKworaWYoQlVJTERfVVRJTElUSUVTKQorICAgIGluc3RhbGwoVEFSR0VU
UyBsemZfYmluIERFU1RJTkFUSU9OIGJpbikKK2VuZGlmKCkKKworaW5zdGFsbChGSUxFUyBsemYu
aCBERVNUSU5BVElPTiBpbmNsdWRlKQorCitpZihJTlNUQUxMX0RPQykKKyAgaW5zdGFsbChGSUxF
UyAke2RvY3N9IERFU1RJTkFUSU9OICR7Q01BS0VfSU5TVEFMTF9QUkVGSVh9L3NoYXJlL2xmeikK
K2VuZGlmKCkKCi0tLSBjb25maWcuaAkyMDIyLTAxLTE4IDE3OjMyOjM3LjAxNjc5OTUwMCArMDAw
MAorKysgY29uZmlnLmgJMjAyMi0wMS0xOCAxNzozNDo1OC4wMDY3OTk1MDAgKzAwMDAKQEAgLTAs
MCArMSwxNyBAQAorLyogY29uZmlnLmguICBHZW5lcmF0ZWQgZnJvbSBjb25maWcuaC5pbiBieSBj
b25maWd1cmUuICAqLworLyogY29uZmlnLmguaW4uICBHZW5lcmF0ZWQgYXV0b21hdGljYWxseSBm
cm9tIGNvbmZpZ3VyZS5pbiBieSBhdXRvaGVhZGVyIDIuMTMuICAqLworCisvKiBEZWZpbmUgdG8g
ZW1wdHkgaWYgdGhlIGtleXdvcmQgZG9lcyBub3Qgd29yay4gICovCisvKiAjdW5kZWYgY29uc3Qg
Ki8KKworLyogRGVmaW5lIGlmIHlvdSBoYXZlIHRoZSBBTlNJIEMgaGVhZGVyIGZpbGVzLiAgKi8K
KyNkZWZpbmUgU1REQ19IRUFERVJTIDEKKworLyogVGhlIG51bWJlciBvZiBieXRlcyBpbiBhIGlu
dC4gICovCisjZGVmaW5lIFNJWkVPRl9JTlQgNAorCisvKiBUaGUgbnVtYmVyIG9mIGJ5dGVzIGlu
IGEgbG9uZy4gICovCisjZGVmaW5lIFNJWkVPRl9MT05HIDgKKworLyogVGhlIG51bWJlciBvZiBi
eXRlcyBpbiBhIHNob3J0LiAgKi8KKyNkZWZpbmUgU0laRU9GX1NIT1JUIDIKLS0tIGx6ZlAuaAky
MDIyLTAxLTE5IDAwOjI5OjE0LjgyNjAwMDAwMCArMDAwMAorKysgbHpmUC5oCTIwMjItMDEtMTkg
MDA6MzA6MDYuMTk5MjQ3MzAwICswMDAwCkBAIC03OSw3ICs3OSwxMSBAQAogICogVW5jb25kaXRp
b25hbGx5IGFsaWduaW5nIGRvZXMgbm90IGNvc3QgdmVyeSBtdWNoLCBzbyBkbyBpdCBpZiB1bnN1
cmUKICAqLwogI2lmbmRlZiBTVFJJQ1RfQUxJR04KLSMgZGVmaW5lIFNUUklDVF9BTElHTiAhKGRl
ZmluZWQoX19pMzg2KSB8fCBkZWZpbmVkIChfX2FtZDY0KSkKKyNpZiAhKGRlZmluZWQoX19pMzg2
KSB8fCBkZWZpbmVkIChfX2FtZDY0KSkKKyMgZGVmaW5lIFNUUklDVF9BTElHTiAxCisjZWxzZQor
IyBkZWZpbmUgU1RSSUNUX0FMSUdOIDAKKyNlbmRpZgogI2VuZGlmCiAKIC8qCg==
XB64_PATCH

# Filelist
# --------
# include/lzf.h
# lib/pkgconfig/liblzf.pc
# lib/liblzf.so
# lib/liblzf.a
# share/doc/liblzf/LICENSE
# bin/lzf
