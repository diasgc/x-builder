#!/bin/bash

lib='libgme'
apt='libgme-dev'
dsc='Blarggs video game music emulation library'
lic='LGPL-2.1'
src='https://bitbucket.org/mpyne/game-music-emu.git'
cfg='cmake'
eta='60'
cmake_static='BUILD_STATIC_LIBS'

lst_inc='gme/*.h'
lst_lib='libgme'
lst_bin=''
lst_lic='license.txt license.gpl2.txt'
lst_pc='libgme.pc'

dev_bra='master'
dev_vrs='0.7.0'
stb_bra=''
stb_vrs=''

. xbuilder.sh

start

# patch on CMakeLists.txt and gme/CMakeLists.txt to support dual static shared build
<<'XB64_PATCH'
LS0tIGdtZS9DTWFrZUxpc3RzLnR4dAkyMDIyLTAyLTEzIDA4OjQzOjE5LjkzMTA4ODkwMCArMDAw
MAorKysgZ21lL0NNYWtlTGlzdHMudHh0CTIwMjItMDItMTMgMDk6MjU6MjUuMjExMDg4OTAwICsw
MDAwCkBAIC0xNjIsNTUgKzE2Miw2NCBAQAogIyBGb3IgdGhlIGdtZV90eXBlcy5oCiBpbmNsdWRl
X2RpcmVjdG9yaWVzKCR7Q01BS0VfQ1VSUkVOVF9CSU5BUllfRElSfSkKIAotIyBBZGQgbGlicmFy
eSB0byBiZSBjb21waWxlZC4KLWFkZF9saWJyYXJ5KGdtZSAke2xpYmdtZV9TUkNTfSkKLQotaWYo
WkxJQl9GT1VORCkKLSAgICBtZXNzYWdlKCIgKiogWkxpYiBsaWJyYXJ5IGxvY2F0ZWQsIGNvbXBy
ZXNzZWQgZmlsZSBmb3JtYXRzIHdpbGwgYmUgc3VwcG9ydGVkIikKLSAgICB0YXJnZXRfY29tcGls
ZV9kZWZpbml0aW9ucyhnbWUgUFJJVkFURSAtREhBVkVfWkxJQl9IKQotICAgIHRhcmdldF9pbmNs
dWRlX2RpcmVjdG9yaWVzKGdtZSBQUklWQVRFICR7WkxJQl9JTkNMVURFX0RJUlN9KQotICAgIHRh
cmdldF9saW5rX2xpYnJhcmllcyhnbWUgJHtaTElCX0xJQlJBUklFU30pCi0gICAgIyBJcyBub3Qg
dG8gYmUgaW5zdGFsbGVkIHRob3VnaAotCi0gICAgc2V0KFBLR19DT05GSUdfWkxJQiAtbHopICMg
ZXZhbHVhdGVkIGluIGxpYmdtZS5wYy5pbgotZWxzZSgpCi0gICAgbWVzc2FnZSgiWkxpYiBsaWJy
YXJ5IG5vdCBmb3VuZCwgZGlzYWJsaW5nIHN1cHBvcnQgZm9yIGNvbXByZXNzZWQgZm9ybWF0cyBz
dWNoIGFzIFZHWiIpCi1lbmRpZigpCi0KLWlmKFVTRV9HTUVfU1BDKQotICAgIGlmKFVOUkFSX0ZP
VU5EKQotICAgICAgICBtZXNzYWdlKCIgKiogdW5SQVIgbGlicmFyeSBsb2NhdGVkLCB0aGUgUlNO
IGZpbGUgZm9ybWF0IHdpbGwgYmUgc3VwcG9ydGVkIikKLSAgICAgICAgdGFyZ2V0X2NvbXBpbGVf
ZGVmaW5pdGlvbnMoZ21lIFBSSVZBVEUgLURSQVJETEwpCi0gICAgICAgIHRhcmdldF9pbmNsdWRl
X2RpcmVjdG9yaWVzKGdtZSBQUklWQVRFICR7VU5SQVJfSU5DTFVERV9ESVJTfSkKLSAgICAgICAg
dGFyZ2V0X2xpbmtfbGlicmFyaWVzKGdtZSAke1VOUkFSX0xJQlJBUklFU30pCitmdW5jdGlvbihm
bl9hZGRsaWIgbGliIHR5cGUpCisgICAgIyBBZGQgbGlicmFyeSB0byBiZSBjb21waWxlZC4KKyAg
ICBhZGRfbGlicmFyeSgke2xpYn0gJHt0eXBlfSAke2xpYmdtZV9TUkNTfSkKKyAgICBpZihaTElC
X0ZPVU5EKQorICAgICAgICBtZXNzYWdlKCIgKiogWkxpYiBsaWJyYXJ5IGxvY2F0ZWQsIGNvbXBy
ZXNzZWQgZmlsZSBmb3JtYXRzIHdpbGwgYmUgc3VwcG9ydGVkIikKKyAgICAgICAgdGFyZ2V0X2Nv
bXBpbGVfZGVmaW5pdGlvbnMoJHtsaWJ9IFBSSVZBVEUgLURIQVZFX1pMSUJfSCkKKyAgICAgICAg
dGFyZ2V0X2luY2x1ZGVfZGlyZWN0b3JpZXMoJHtsaWJ9IFBSSVZBVEUgJHtaTElCX0lOQ0xVREVf
RElSU30pCisgICAgICAgIHRhcmdldF9saW5rX2xpYnJhcmllcygke2xpYn0gJHtaTElCX0xJQlJB
UklFU30pCiAgICAgICAgICMgSXMgbm90IHRvIGJlIGluc3RhbGxlZCB0aG91Z2gKIAotICAgICAg
ICBzZXQoUEtHX0NPTkZJR19VTlJBUiAtbHVucmFyKSAjIGV2YWx1YXRlZCBpbiBsaWJnbWUucGMu
aW4KKyAgICAgICAgc2V0KFBLR19DT05GSUdfWkxJQiAtbHopICMgZXZhbHVhdGVkIGluIGxpYmdt
ZS5wYy5pbgogICAgIGVsc2UoKQotICAgICAgICBtZXNzYWdlKCJ1blJBUiBsaWJyYXJ5IG5vdCBm
b3VuZCwgZGlzYWJsaW5nIHN1cHBvcnQgZm9yIHRoZSBSU04gZmlsZSBmb3JtYXQiKQorICAgICAg
ICBtZXNzYWdlKCJaTGliIGxpYnJhcnkgbm90IGZvdW5kLCBkaXNhYmxpbmcgc3VwcG9ydCBmb3Ig
Y29tcHJlc3NlZCBmb3JtYXRzIHN1Y2ggYXMgVkdaIikKICAgICBlbmRpZigpCi1lbmRpZigpCi0j
IFRoZSB2ZXJzaW9uIGlzIHRoZSByZWxlYXNlLiAgVGhlICJzb3ZlcnNpb24iIGlzIHRoZSBBUEkg
dmVyc2lvbi4gIEFzIGxvbmcKLSMgYXMgb25seSBidWlsZCBmaXhlcyBhcmUgcGVyZm9ybWVkIChp
LmUuIG5vIGJhY2t3YXJkcy1pbmNvbXBhdGlibGUgY2hhbmdlcwotIyB0byB0aGUgQVBJKSwgdGhl
IFNPVkVSU0lPTiBzaG91bGQgYmUgdGhlIHNhbWUgZXZlbiB3aGVuIGJ1bXBpbmcgdXAgVkVSU0lP
Ti4KLSMgVGhlIHdheSBnbWUuaCBpcyBkZXNpZ25lZCwgU09WRVJTSU9OIHNob3VsZCB2ZXJ5IHJh
cmVseSBiZSBidW1wZWQsIGlmIGV2ZXIuCi0jIEhvcGVmdWxseSB0aGUgQVBJIGNhbiBzdGF5IGNv
bXBhdGlibGUgd2l0aCBvbGQgdmVyc2lvbnMuCi1zZXRfdGFyZ2V0X3Byb3BlcnRpZXMoZ21lCi0g
ICAgUFJPUEVSVElFUyBWRVJTSU9OICR7R01FX1ZFUlNJT059Ci0gICAgICAgICAgICAgICBTT1ZF
UlNJT04gMSkKLQotIyBtYWNPUyBmcmFtZXdvcmsgYnVpbGQKLWlmKEJVSUxEX0ZSQU1FV09SSykK
LSAgICBzZXRfdGFyZ2V0X3Byb3BlcnRpZXMoZ21lCi0gICAgICAgIFBST1BFUlRJRVMgRlJBTUVX
T1JLIFRSVUUKLSAgICAgICAgICAgICAgICAgICBGUkFNRVdPUktfVkVSU0lPTiBBCi0gICAgICAg
ICAgICAgICAgICAgTUFDT1NYX0ZSQU1FV09SS19JREVOVElGSUVSIG5ldC5tcHluZS5nbWUKLSAg
ICAgICAgICAgICAgICAgICBWRVJTSU9OICR7R01FX1ZFUlNJT059Ci0gICAgICAgICAgICAgICAg
ICAgU09WRVJTSU9OIDAKLSAgICAgICAgICAgICAgICAgICBQVUJMSUNfSEVBREVSICIke0VYUE9S
VEVEX0hFQURFUlN9IikKKworICAgIGlmKFVTRV9HTUVfU1BDKQorICAgICAgICBpZihVTlJBUl9G
T1VORCkKKyAgICAgICAgICAgIG1lc3NhZ2UoIiAqKiB1blJBUiBsaWJyYXJ5IGxvY2F0ZWQsIHRo
ZSBSU04gZmlsZSBmb3JtYXQgd2lsbCBiZSBzdXBwb3J0ZWQiKQorICAgICAgICAgICAgdGFyZ2V0
X2NvbXBpbGVfZGVmaW5pdGlvbnMoJHtsaWJ9IFBSSVZBVEUgLURSQVJETEwpCisgICAgICAgICAg
ICB0YXJnZXRfaW5jbHVkZV9kaXJlY3Rvcmllcygke2xpYn0gUFJJVkFURSAke1VOUkFSX0lOQ0xV
REVfRElSU30pCisgICAgICAgICAgICB0YXJnZXRfbGlua19saWJyYXJpZXMoJHtsaWJ9ICR7VU5S
QVJfTElCUkFSSUVTfSkKKyAgICAgICAgICAgICMgSXMgbm90IHRvIGJlIGluc3RhbGxlZCB0aG91
Z2gKKworICAgICAgICAgICAgc2V0KFBLR19DT05GSUdfVU5SQVIgLWx1bnJhcikgIyBldmFsdWF0
ZWQgaW4gbGliZ21lLnBjLmluCisgICAgICAgIGVsc2UoKQorICAgICAgICAgICAgbWVzc2FnZSgi
dW5SQVIgbGlicmFyeSBub3QgZm91bmQsIGRpc2FibGluZyBzdXBwb3J0IGZvciB0aGUgUlNOIGZp
bGUgZm9ybWF0IikKKyAgICAgICAgZW5kaWYoKQorICAgIGVuZGlmKCkKKyAgICAjIFRoZSB2ZXJz
aW9uIGlzIHRoZSByZWxlYXNlLiAgVGhlICJzb3ZlcnNpb24iIGlzIHRoZSBBUEkgdmVyc2lvbi4g
IEFzIGxvbmcKKyAgICAjIGFzIG9ubHkgYnVpbGQgZml4ZXMgYXJlIHBlcmZvcm1lZCAoaS5lLiBu
byBiYWNrd2FyZHMtaW5jb21wYXRpYmxlIGNoYW5nZXMKKyAgICAjIHRvIHRoZSBBUEkpLCB0aGUg
U09WRVJTSU9OIHNob3VsZCBiZSB0aGUgc2FtZSBldmVuIHdoZW4gYnVtcGluZyB1cCBWRVJTSU9O
LgorICAgICMgVGhlIHdheSBnbWUuaCBpcyBkZXNpZ25lZCwgU09WRVJTSU9OIHNob3VsZCB2ZXJ5
IHJhcmVseSBiZSBidW1wZWQsIGlmIGV2ZXIuCisgICAgIyBIb3BlZnVsbHkgdGhlIEFQSSBjYW4g
c3RheSBjb21wYXRpYmxlIHdpdGggb2xkIHZlcnNpb25zLgorICAgIHNldF90YXJnZXRfcHJvcGVy
dGllcygke2xpYn0KKyAgICAgICAgUFJPUEVSVElFUyBWRVJTSU9OICR7R01FX1ZFUlNJT059Cisg
ICAgICAgICAgICAgICAgU09WRVJTSU9OIDEKKyAgICAgICAgICAgICAgICBPVVRQVVRfTkFNRSBn
bWUpCisKKyAgICAjIG1hY09TIGZyYW1ld29yayBidWlsZAorICAgIGlmKEJVSUxEX0ZSQU1FV09S
SykKKyAgICAgICAgc2V0X3RhcmdldF9wcm9wZXJ0aWVzKCR7bGlifQorICAgICAgICAgICAgUFJP
UEVSVElFUyBGUkFNRVdPUksgVFJVRQorICAgICAgICAgICAgICAgICAgICBGUkFNRVdPUktfVkVS
U0lPTiBBCisgICAgICAgICAgICAgICAgICAgIE1BQ09TWF9GUkFNRVdPUktfSURFTlRJRklFUiBu
ZXQubXB5bmUuZ21lCisgICAgICAgICAgICAgICAgICAgIFZFUlNJT04gJHtHTUVfVkVSU0lPTn0K
KyAgICAgICAgICAgICAgICAgICAgU09WRVJTSU9OIDAKKyAgICAgICAgICAgICAgICAgICAgUFVC
TElDX0hFQURFUiAiJHtFWFBPUlRFRF9IRUFERVJTfSIpCisgICAgZW5kaWYoKQorZW5kZnVuY3Rp
b24oKQorCitzZXQodGFyZ2V0cyBnbWUpCitmbl9hZGRsaWIoZ21lICIiKQoraWYoQlVJTERfU0hB
UkVEX0xJQlMgQU5EIEJVSUxEX1NUQVRJQ19MSUJTKQorICAgIGZuX2FkZGxpYihnbWUtc3RhdGlj
IFNUQVRJQykKKyAgICBsaXN0KEFQUEVORCB0YXJnZXRzIGdtZS1zdGF0aWMpCiBlbmRpZigpCiAK
LWluc3RhbGwoVEFSR0VUUyBnbWUgTElCUkFSWSBERVNUSU5BVElPTiBsaWIke0xJQl9TVUZGSVh9
CitpbnN0YWxsKFRBUkdFVFMgJHt0YXJnZXRzfSBMSUJSQVJZIERFU1RJTkFUSU9OIGxpYiR7TElC
X1NVRkZJWH0KICAgICAgICAgICAgICAgICAgICAgUlVOVElNRSBERVNUSU5BVElPTiBiaW4gIyBE
TEwgcGxhdGZvcm1zCiAgICAgICAgICAgICAgICAgICAgIEFSQ0hJVkUgREVTVElOQVRJT04gbGli
ICMgRExMIHBsYXRmb3JtcwogICAgICAgICAgICAgICAgICAgICBGUkFNRVdPUksgREVTVElOQVRJ
T04gL0xpYnJhcnkvRnJhbWV3b3JrcykgIyBtYWNPUyBmcmFtZXdvcmsKCi0tLSBDTWFrZUxpc3Rz
LnR4dAkyMDIyLTAyLTEzIDA4OjQwOjQ0Ljk5MTA4ODkwMCArMDAwMAorKysgQ01ha2VMaXN0cy50
eHQJMjAyMi0wMi0xMyAwODo1NToyNy40NDEwODg5MDAgKzAwMDAKQEAgLTYyLDcgKzYyLDcgQEAK
ICAgICBTRVQoVVNFX0dNRV9OU0YgMSBDQUNIRSBCT09MICJFbmFibGUgTkVTIE5TRiBtdXNpYyBl
bXVsYXRpb24iIEZPUkNFKQogZW5kaWYoKQogCi1vcHRpb24oQlVJTERfU0hBUkVEX0xJQlMgIkJ1
aWxkIHNoYXJlZCBsaWJyYXJ5IChzZXQgdG8gT0ZGIGZvciBzdGF0aWMgbGlicmFyeSkiIE9OKQor
b3B0aW9uKEJVSUxEX1NUQVRJQ19MSUJTICJCdWlsZCBzdGF0aWMgbGlicmFyeSIgT04pCiAKIG9w
dGlvbihFTkFCTEVfVUJTQU4gIkVuYWJsZSBVbmRlZmluZWQgQmVoYXZpb3IgU2FuaXRpemVyIGVy
cm9yLWNoZWNraW5nIiBPTikKIAo=
XB64_PATCH

# cpu av8 av7 x86 x64
# NDK ++  ++   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# Filelist
# --------
# include/gme/gme.h
# include/gme/blargg_source.h
# lib/pkgconfig/libgme.pc
# lib/libgme.a
# lib/libgme.so
# share/doc/libgme/license.txt
# share/doc/libgme/license.gpl2.txt
