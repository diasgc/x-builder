#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++  .   .  clang
# GNU +++  .   .   .  gcc
# WIN +++ +++  .  +++ clang/gcc

lib='exhale'
apt=''
dsc='an open-source ISO/IEC 23003-3 (USAC, xHE-AAC) encoder'
lic='Copyright'
src='https://gitlab.com/ecodis/exhale.git'
cfg='cmake'
eta='150'
pc_llib="-lexhale"

. xbuilder.sh

cmake_config="-DBUILD_TESTS=OFF -DCMAKE_DL_LIBS=ON"

start

<<'XB64_PATCH'
LS0tIHNyYy9saWIvQ01ha2VMaXN0cy50eHQJMjAyMS0xMC0wNyAxNTo1MzozOC4xNTAwMDAwMDAg
KzAxMDAKKysrIHNyYy9saWIvQ01ha2VMaXN0cy50eHQJMjAyMS0xMC0wNyAxNjowODozMy4zMDAw
MDAwMDAgKzAxMDAKQEAgLTcsNTEgKzcsMzkgQEAKICAjCiAgIyBDb3B5cmlnaHQgKGMpIDIwMTgt
MjAyMSBDaHJpc3RpYW4gUi4gSGVsbXJpY2gsIHByb2plY3QgZWNvZGlzLiBBbGwgcmlnaHRzIHJl
c2VydmVkLgogICMjCi0KLWFkZF9saWJyYXJ5KGV4aGFsZUxpYgotICAgIGxhcHBlZFRyYW5zZm9y
bS5jcHAKLSAgICBleGhhbGVMaWJQY2guY3BwCi0gICAgYml0U3RyZWFtV3JpdGVyLmNwcAotICAg
IHF1YW50aXphdGlvbi5jcHAKLSAgICBzdGVyZW9Qcm9jZXNzaW5nLmgKLSAgICBleGhhbGVMaWJQ
Y2guaAotICAgIGVudHJvcHlDb2RpbmcuY3BwCi0gICAgdGVtcEFuYWx5c2lzLmNwcAotICAgIGJp
dEFsbG9jYXRpb24uY3BwCi0gICAgc3RlcmVvUHJvY2Vzc2luZy5jcHAKLSAgICBiaXRBbGxvY2F0
aW9uLmgKLSAgICBiaXRTdHJlYW1Xcml0ZXIuaAotICAgIHNwZWNBbmFseXNpcy5oCi0gICAgc3Bl
Y0FuYWx5c2lzLmNwcAotICAgIGxhcHBlZFRyYW5zZm9ybS5oCi0gICAgc3BlY0dhcEZpbGxpbmcu
Y3BwCi0gICAgc3BlY0dhcEZpbGxpbmcuaAotICAgIGxpbmVhclByZWRpY3Rpb24uaAotICAgIHF1
YW50aXphdGlvbi5oCi0gICAgZW50cm9weUNvZGluZy5oCi0gICAgZXhoYWxlRW5jLmNwcAotICAg
IHRlbXBBbmFseXNpcy5oCi0gICAgbGluZWFyUHJlZGljdGlvbi5jcHAKLSAgICBleGhhbGVFbmMu
aAorZmlsZShHTE9CIHNyY19leGhhbGUKKyAgICAqLmNwcAorICAgICouaAogICAgICR7UFJPSkVD
VF9TT1VSQ0VfRElSfS9pbmNsdWRlL2V4aGFsZURlY2wuaAogICAgICR7UFJPSkVDVF9TT1VSQ0Vf
RElSfS9pbmNsdWRlL3ZlcnNpb24uaCkKIAotc2V0X3RhcmdldF9wcm9wZXJ0aWVzKGV4aGFsZUxp
YiBQUk9QRVJUSUVTIE9VVFBVVF9OQU1FIGV4aGFsZSkKLQotaWYoVEFSR0VUIFRocmVhZHM6OlRo
cmVhZHMpCi0gICAgdGFyZ2V0X2xpbmtfbGlicmFyaWVzKGV4aGFsZUxpYiBQUklWQVRFIFRocmVh
ZHM6OlRocmVhZHMpCi1lbmRpZigpCi1pZihDTUFLRV9ETF9MSUJTKQotICAgIHRhcmdldF9saW5r
X2xpYnJhcmllcyhleGhhbGVMaWIgUFJJVkFURSAke0NNQUtFX0RMX0xJQlN9KQoraWYoQlVJTERf
U0hBUkVEX0xJQlMpCisgICAgc2V0KFRBUkdFVFMgZXhoYWxlTGliIGV4aGFsZUxpYi1zdGF0aWMp
CisgICAgYWRkX2xpYnJhcnkoZXhoYWxlTGliIFNIQVJFRCAke3NyY19leGhhbGV9KQorICAgIGFk
ZF9saWJyYXJ5KGV4aGFsZUxpYi1zdGF0aWMgU1RBVElDICR7c3JjX2V4aGFsZX0pCitlbHNlKCkK
KyAgICBzZXQoVEFSR0VUUyBleGhhbGVMaWIpCisgICAgYWRkX2xpYnJhcnkoZXhoYWxlTGliICR7
c3JjX2V4aGFsZX0pCiBlbmRpZigpCi10YXJnZXRfaW5jbHVkZV9kaXJlY3RvcmllcyhleGhhbGVM
aWIgUFJJVkFURSAke1BST0pFQ1RfU09VUkNFX0RJUn0vaW5jbHVkZSkKIAotIyBQQ0ggcmVxdWly
ZXMgYXQgbGVhc3QgMy4xNgotIyBJIGFjdHVhbGx5IGRvbid0IGtub3cgaWYgdGhpcyB3b3JrcyBv
ciBub3QKLWlmKENNQUtFX1ZFUlNJT04gVkVSU0lPTl9HUkVBVEVSICIzLjE2LjAiKQotICAgIHRh
cmdldF9wcmVjb21waWxlX2hlYWRlcnMoZXhoYWxlTGliIFBVQkxJQyAke1BST0pFQ1RfU09VUkNF
X0RJUn0vc3JjL2xpYi9leGhhbGVMaWJQY2guaCkKLWVuZGlmKCkKK2ZvcmVhY2godGFyZ2V0ICR7
VEFSR0VUU30pCisgICAgc2V0X3RhcmdldF9wcm9wZXJ0aWVzKCR7dGFyZ2V0fSBQUk9QRVJUSUVT
IE9VVFBVVF9OQU1FIGV4aGFsZSkKKworICAgIGlmKFRBUkdFVCBUaHJlYWRzOjpUaHJlYWRzKQor
ICAgICAgICB0YXJnZXRfbGlua19saWJyYXJpZXMoJHt0YXJnZXR9IFBSSVZBVEUgVGhyZWFkczo6
VGhyZWFkcykKKyAgICBlbmRpZigpCisgICAgaWYoQ01BS0VfRExfTElCUykKKyAgICAgICAgdGFy
Z2V0X2xpbmtfbGlicmFyaWVzKCR7dGFyZ2V0fSBQUklWQVRFICR7Q01BS0VfRExfTElCU30pCisg
ICAgZW5kaWYoKQorICAgIHRhcmdldF9pbmNsdWRlX2RpcmVjdG9yaWVzKCR7dGFyZ2V0fSBQUklW
QVRFICR7UFJPSkVDVF9TT1VSQ0VfRElSfS9pbmNsdWRlKQorCisgICAgIyBQQ0ggcmVxdWlyZXMg
YXQgbGVhc3QgMy4xNgorICAgICMgSSBhY3R1YWxseSBkb24ndCBrbm93IGlmIHRoaXMgd29ya3Mg
b3Igbm90CisgICAgaWYoQ01BS0VfVkVSU0lPTiBWRVJTSU9OX0dSRUFURVIgIjMuMTYuMCIpCisg
ICAgICAgIHRhcmdldF9wcmVjb21waWxlX2hlYWRlcnMoJHt0YXJnZXR9IFBVQkxJQyAke1BST0pF
Q1RfU09VUkNFX0RJUn0vc3JjL2xpYi9leGhhbGVMaWJQY2guaCkKKyAgICBlbmRpZigpCitlbmRm
b3JlYWNoKHRhcmdldCAke1RBUkdFVFN9KQogCi1pbnN0YWxsKFRBUkdFVFMgZXhoYWxlTGliCitp
bnN0YWxsKFRBUkdFVFMgJHtUQVJHRVRTfQogICAgIEFSQ0hJVkUgREVTVElOQVRJT04gJHtDTUFL
RV9JTlNUQUxMX0ZVTExfTElCRElSfQogICAgIExJQlJBUlkgREVTVElOQVRJT04gJHtDTUFLRV9J
TlNUQUxMX0ZVTExfTElCRElSfSkKCi0tLSBzcmMvYXBwL0NNYWtlTGlzdHMudHh0CTIwMjEtMTAt
MDcgMTY6NTc6MjIuOTUwMDAwMDAwICswMTAwCisrKyBzcmMvYXBwL0NNYWtlTGlzdHMudHh0CTIw
MjEtMTAtMDcgMTY6NTc6MjEuMzMwMDAwMDAwICswMTAwCkBAIC0zMSw3ICszMSwxMyBAQAogaWYo
Q01BS0VfRExfTElCUykKICAgICB0YXJnZXRfbGlua19saWJyYXJpZXMoZXhoYWxlQXBwIFBSSVZB
VEUgJHtDTUFLRV9ETF9MSUJTfSkKIGVuZGlmKCkKLXRhcmdldF9saW5rX2xpYnJhcmllcyhleGhh
bGVBcHAgUFJJVkFURSBleGhhbGVMaWIpCisKK2lmKEJVSUxEX1NIQVJFRF9MSUJTKQordGFyZ2V0
X2xpbmtfbGlicmFyaWVzKGV4aGFsZUFwcCBQUklWQVRFIGV4aGFsZUxpYi1zdGF0aWMpCitlbHNl
KCkKK3RhcmdldF9saW5rX2xpYnJhcmllcyhleGhhbGVBcHAgUFJJVkFURSBleGhhbGVMaWIpCitl
bmRpZigpCisKIHRhcmdldF9pbmNsdWRlX2RpcmVjdG9yaWVzKGV4aGFsZUFwcCBQUklWQVRFICR7
UFJPSkVDVF9TT1VSQ0VfRElSfS9pbmNsdWRlKQogCiAjIFBDSCByZXF1aXJlcyBhdCBsZWFzdCAz
LjE2CgotLS0gc3JjL2FwcC9leGhhbGVBcHAucmMJMjAyMS0xMC0wNyAxNzo1NzoxNS43MTAwMDAw
MDAgKzAxMDAKKysrIHNyYy9hcHAvZXhoYWxlQXBwLnJjCTIwMjEtMTAtMDcgMTc6NTc6MTQuMTcw
MDAwMDAwICswMTAwCkBAIC04LDcgKzgsNyBAQAogICogQ29weXJpZ2h0IChjKSAyMDE4LTIwMjEg
Q2hyaXN0aWFuIFIuIEhlbG1yaWNoLCBwcm9qZWN0IGVjb2Rpcy4gQWxsIHJpZ2h0cyByZXNlcnZl
ZC4KICAqLwogCi0jaW5jbHVkZSAiLi5cLi5caW5jbHVkZVx2ZXJzaW9uLmgiIC8vIGZvciBFWEhB
TEVMSUJfVkVSU0lPTl8uLi4gc3RyaW5ncworI2luY2x1ZGUgIi4uLy4uL2luY2x1ZGUvdmVyc2lv
bi5oIiAvLyBmb3IgRVhIQUxFTElCX1ZFUlNJT05fLi4uIHN0cmluZ3MKICNpbmNsdWRlIDx3aW5k
b3dzLmg+CiAKIDAgSUNPTiAiZXhoYWxlQXBwLmljbyI=
XB64_PATCH


# Filelist
# --------
# lib/pkgconfig/exhale.pc
# lib/libexhale.so
# lib/libexhale.a
# bin/exhale
