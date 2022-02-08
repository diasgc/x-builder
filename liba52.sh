#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='liba52'
vrs='0.7.4'
apt="liba52-${vrs}-dev"
dsc='liba52 is a free library for decoding ATSC A/52 streams'
lic='GPL'
src="https://liba52.sourceforge.io/files/a52dec-${vrs}.tar.gz"
cfg='cmake'
cmake_static='BUILD_STATIC_LIBS'
eta='10'

pc_llib='-la52'

lst_inc='a52.h'
lst_lib='liba52'
lst_bin='a52dec extract_a52'
lst_lic='COPYING AUTHORS'
lst_pc='liba52.pc'

dev_bra=''
dev_vrs='0.7.4'
stb_bra=''
stb_vrs='0.7.4'

. xbuilder.sh

start

<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMudHh0CTE5NzAtMDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyBDTWFrZUxpc3
RzLnR4dAkyMDIyLTAyLTA3IDIxOjU3OjMxLjUwNTk1ODYwMCArMDAwMApAQCAtMCwwICsxLDE0MyBAQAorY21ha2Vf
bWluaW11bV9yZXF1aXJlZChWRVJTSU9OIDMuMTApCisKK3Byb2plY3QobGliYTUyIAorICBMQU5HVUFHRVMgQworIC
BWRVJTSU9OICIwLjcuNCIKKyAgSE9NRVBBR0VfVVJMICJodHRwczovL2xpYmE1Mi5zb3VyY2Vmb3JnZS5pby8iCisg
IERFU0NSSVBUSU9OICJMaWJhNTIgaXMgYSBmcmVlIGxpYnJhcnkgZm9yIGRlY29kaW5nIEFUU0MgQS81MiBzdHJlYW
1zIgorICApCisKKyNjb25maWd1cmVfZmlsZShpbmNsdWRlL2NvbmZpZy5oLmluICR7Q01BS0VfU09VUkNFX0RJUn0v
aW5jbHVkZS9jb25maWcuaCkKK2FkZF9jdXN0b21fdGFyZ2V0KHJ1biBBTEwgQ09NTUFORCB0b3VjaCAke0NNQUtFX1
NPVVJDRV9ESVJ9L2luY2x1ZGUvY29uZmlnLmgpCisKK29wdGlvbihCVUlMRF9TVEFUSUNfTElCUyAiQnVpbGQgc3Rh
dGljIGxpYnMiIE9OKQorb3B0aW9uKEJVSUxEX0VYRUNVVEFCTEVTICJCdWlsZCBleGVjdXRhYmxlcyIgT04pCitvcH
Rpb24oQlVJTERfTUFOUEFHRVMgIkJ1aWxkIG1hbiBwYWdlcyIgT04pCitvcHRpb24oTElCQTUyX0RKQkZGVCAibGli
YTUyIGRqYmZmdCBzdXBwb3J0IiBPRkYpCitvcHRpb24oTElCQTUyX0RPVUJMRSAiYTUyIHNhbXBsZSBwcmVjaXNpb2
4iIE9OKQorb3B0aW9uKExJQkFPX0FMICJsaWJhbyBhbCBzdXBwb3J0IiBPRkYpCitvcHRpb24oTElCQU9fT1NTICJs
aWJhbyBPU1Mgc3VwcG9ydCIgT0ZGKQorb3B0aW9uKExJQkFPX1NPTEFSSVMgImxpYmFvIHNvbGFyaXMgc3VwcG9ydC
IgT0ZGKQorb3B0aW9uKExJQkFPX1dJTiAibGliYW8gd2luIHN1cHBvcnQiIE9GRikKKworYWRkX2RlZmluaXRpb25z
KCItV25vLXNoaWZ0LW5lZ2F0aXZlLXZhbHVlIikKK2ZvcmVhY2goYWEgTElCQTUyX0RKQkZGVCBMSUJBNTJfRE9VQk
xFIExJQkFPX0FMIExJQkFPX09TUyBMSUJBT19TT0xBUklTIExJQkFPX1dJTikKKyAgaWYoJHthYX0pCisgICAgYWRk
X2RlZmluaXRpb25zKC1EJHthYX0pCisgIGVuZGlmKCkKK2VuZGZvcmVhY2goKQorCitpbmNsdWRlIChDaGVja0luY2
x1ZGVGaWxlcykKK0NIRUNLX0lOQ0xVREVfRklMRVMgKGRsZmNuLmggSEFWRV9ETEZDTl9IKQorQ0hFQ0tfSU5DTFVE
RV9GSUxFUyAoaW50dHlwZXMuaCBIQVZFX0lOVFRZUEVTX0gpCitDSEVDS19JTkNMVURFX0ZJTEVTIChpby5oIEhBVk
VfSU9fSCkKK0NIRUNLX0lOQ0xVREVfRklMRVMgKG1lbW9yeS5oIEhBVkVfTUVNT1JZX0gpCitDSEVDS19JTkNMVURF
X0ZJTEVTIChzdGRpbnQuaCBIQVZFX1NURElOVF9IKQorQ0hFQ0tfSU5DTFVERV9GSUxFUyAoc3RkbGliLmggSEFWRV
9TVERMSUJfSCkKK0NIRUNLX0lOQ0xVREVfRklMRVMgKHN0cmluZ3MuaCBIQVZFX1NUUklOR1NfSCkKK0NIRUNLX0lO
Q0xVREVfRklMRVMgKHN0cmluZy5oIEhBVkVfU1RSSU5HX0gpCitDSEVDS19JTkNMVURFX0ZJTEVTIChzeXMvc3RhdC
5oIEhBVkVfU1lTX1NUQVRfSCkKK0NIRUNLX0lOQ0xVREVfRklMRVMgKHN5cy90aW1lYi5oIEhBVkVfU1lTX1RJTUVC
X0gpCitDSEVDS19JTkNMVURFX0ZJTEVTIChzeXMvdGltZS5oIEhBVkVfU1lTX1RJTUVfSCkKK0NIRUNLX0lOQ0xVRE
VfRklMRVMgKHN5cy90eXBlcy5oIEhBVkVfU1lTX1RZUEVTX0gpCitDSEVDS19JTkNMVURFX0ZJTEVTICh1bmlzdGQu
aCBIQVZFX1VOSVNURF9IKQorCitpbmNsdWRlKENoZWNrRnVuY3Rpb25FeGlzdHMpCitDSEVDS19GVU5DVElPTl9FWE
lTVFMgKGZ0aW1lIEhBVkVfRlRJTUUpCitDSEVDS19GVU5DVElPTl9FWElTVFMgKGdldHRpbWVvZmRheSBIQVZFX0dF
VFRJTUVPRkRBWSkKK0NIRUNLX0ZVTkNUSU9OX0VYSVNUUyAobWVtYWxpZ24gSEFWRV9NRU1BTElHTikKKworZm9yZW
FjaChhIEhBVkVfRlRJTUUgSEFWRV9HRVRUSU1FT0ZEQVkgSEFWRV9NRU1BTElHTgorICBIQVZFX0RMRkNOX0gKKyAg
SEFWRV9JTlRUWVBFU19ICisgIEhBVkVfSU9fSAorICBIQVZFX01FTU9SWV9ICisgIEhBVkVfU1RESU5UX0gKKyAgSE
FWRV9TVERMSUJfSAorICBIQVZFX1NUUklOR1NfSAorICBIQVZFX1NUUklOR19ICisgIEhBVkVfU1lTX1NUQVRfSAor
ICBIQVZFX1NZU19USU1FQl9ICisgIEhBVkVfU1lTX1RJTUVfSAorICBIQVZFX1NZU19UWVBFU19ICisgIEhBVkVfVU
5JU1REX0gpCisgIGlmKCR7YX0pCisgICAgYWRkX2NvbXBpbGVfZGVmaW5pdGlvbnMoJHthfT0xKQorICBlbHNlKCkK
KyAgICByZW1vdmVfZGVmaW5pdGlvbnMoJHthfSkKKyAgZW5kaWYoKQorZW5kZm9yZWFjaCgpCisKKworCisKKyMgbW
F4aW11bSBzdXBwb3J0ZWQgZGF0YSBhbGlnbm1lbnQKK2FkZF9kZWZpbml0aW9ucygtREFUVFJJQlVURV9BTElHTkVE
X01BWD02NAorICAtRExUX09CSkRJUj0iLmxpYnMvIgorICAtRFBBQ0tBR0U9ImE1MmRlYyIKKyAgLURWRVJTSU9OPS
Ike1BST0pFQ1RfVkVSU0lPTn0iCisgIC1EUEFDS0FHRV9CVUdSRVBPUlQ9IiIKKyAgLURQQUNLQUdFX05BTUU9IiIK
KyAgLURQQUNLQUdFX1NUUklORz0iIgorICAtRFBBQ0tBR0VfVEFSTkFNRT0iIgorICAtRFBBQ0tBR0VfVVJMPSIke1
BST0pFQ1RfSE9NRVBBR0VfVVJMfSIKKyAgLURQQUNLQUdFX1ZFUlNJT049JHtQUk9KRUNUX1ZFUlNJT059CisgIC1E
UkVUU0lHVFlQRT12b2lkCisgIC1EU1REQ19IRUFERVJTPTEKKyAgKQorCitpbmNsdWRlKENoZWNrVHlwZVNpemUpCi
tDSEVDS19UWVBFX1NJWkUoY2hhciBTSVpFT0ZfQ0hBUikKK0NIRUNLX1RZUEVfU0laRShpbnQgU0laRU9GX0lOVCkK
K0NIRUNLX1RZUEVfU0laRShzaG9ydCBTSVpFT0ZfU0hPUlQpCithZGRfZGVmaW5pdGlvbnMoLURTSVpFT0ZfQ0hBUj
0ke1NJWkVPRl9DSEFSfSAtRFNJWkVPRl9JTlQ9JHtTSVpFT0ZfSU5UfSAtRFNJWkVPRl9TSE9SVD0ke1NJWkVPRl9T
SE9SVH0pCisKKyNjb25maWd1cmVfZmlsZShpbmNsdWRlL2NvbmZpZy5oLmluICR7Q01BS0VfU09VUkNFX0RJUn0vaW
5jbHVkZS9jb25maWcuaCkKKworaW5jbHVkZV9kaXJlY3Rvcmllcygke0NNQUtFX1NPVVJDRV9ESVJ9IGluY2x1ZGUg
bGliYTUyIHNyYyBsaWJhbykKKworZmlsZShHTE9CIHNyY19saWJhNTIgbGliYTUyLyouYykKK2ZpbGUoR0xPQiBoZH
JfbGliYTUyIGxpYmE1Mi8qLmgpCitmaWxlKEdMT0Igc3JjX2xpYmE1MmRlYyBzcmMvKi5jKQorZmlsZShHTE9CIGhk
cl9saWJhNTJkZWMgc3JjLyouaCkKKworc2V0KHNyY19saWJhbyBsaWJhby9hdWRpb19vdXQuYyBsaWJhby9hdWRpb1
9vdXRfYWlmLmMgbGliYW8vYXVkaW9fb3V0X2Zsb2F0LmMgbGliYW8vYXVkaW9fb3V0X251bGwuYyBsaWJhby9hdWRp
b19vdXRfcGVhay5jIGxpYmFvL2F1ZGlvX291dF93YXYuYyBsaWJhby9hdWRpb19vdXRfaW50ZXJuYWwuaCBsaWJhby
9mbG9hdDJzMTYuYykKK3NldChzcmNfYTUyZGVjIHNyYy9hNTJkZWMuYyBzcmMvZ2V0b3B0LmMgc3JjL2dldHRpbWVv
ZmRheS5jKQorc2V0KHNyY19leHRyYWN0X2E1MiBzcmMvZXh0cmFjdF9hNTIuYyBzcmMvZ2V0b3B0LmMpCisKKyNhZG
RfZGVmaW5pdGlvbnMoLURMSUJBT19PU1MgLURMSUJBT19TT0xBUklTIC1ETElCQU9fV0lOKQorYWRkX2xpYnJhcnko
YW8gU1RBVElDICR7c3JjX2xpYmFvfSkKKworYWRkX2xpYnJhcnkoYTUyICR7c3JjX2xpYmE1Mn0pCisKK2lmKEJVSU
xEX1NIQVJFRF9MSUJTIEFORCBCVUlMRF9TVEFUSUNfTElCUykKKyAgYWRkX2xpYnJhcnkoYTUyX3N0YXRpYyBTVEFU
SUMgJHtzcmNfbGliYTUyfSkKKyAgc2V0X3RhcmdldF9wcm9wZXJ0aWVzKGE1Ml9zdGF0aWMgUFJPUEVSVElFUyBPVV
RQVVRfTkFNRSBhNTIpCitlbmRpZigpCisKK2lmKEJVSUxEX0VYRUNVVEFCTEVTKQorICAgIGFkZF9leGVjdXRhYmxl
KGE1MmRlYyBzcmMvYTUyZGVjLmMgc3JjL2dldG9wdC5jIHNyYy9nZXR0aW1lb2ZkYXkuYykKKyAgICB0YXJnZXRfbG
lua19saWJyYXJpZXMoYTUyZGVjIGFvIGE1MikKKyAgICBhZGRfZXhlY3V0YWJsZShleHRyYWN0X2E1MiBzcmMvZXh0
cmFjdF9hNTIuYyBzcmMvZ2V0b3B0LmMpCitlbmRpZigpCisKK2luc3RhbGwoVEFSR0VUUyBhNTIKKyAgUlVOVElNRS
BERVNUSU5BVElPTiBiaW4KKyAgQVJDSElWRSBERVNUSU5BVElPTiBsaWIke0xJQl9TVUZGSVh9CisgIExJQlJBUlkg
REVTVElOQVRJT04gbGliJHtMSUJfU1VGRklYfSkKKworaWYoQlVJTERfU0hBUkVEX0xJQlMgQU5EIEJVSUxEX1NUQV
RJQ19MSUJTKQorICBpbnN0YWxsKFRBUkdFVFMgYTUyX3N0YXRpYyBBUkNISVZFIERFU1RJTkFUSU9OIGxpYiR7TElC
X1NVRkZJWH0pCitlbmRpZigpCisKK2luc3RhbGwoRklMRVMgaW5jbHVkZS9hNTIuaCBERVNUSU5BVElPTiBpbmNsdW
RlKQorCitpZihCVUlMRF9FWEVDVVRBQkxFUykKKyAgaW5zdGFsbChUQVJHRVRTIGE1MmRlYyBSVU5USU1FIERFU1RJ
TkFUSU9OIGJpbikKK2VuZGlmKCkKKworaWYoQlVJTERfTUFOUEFHRVMpCisgIGluc3RhbGwoRklMRVMgc3JjL2E1Mm
RlYy4xIHNyYy9leHRyYWN0X2E1Mi4xIERFU1RJTkFUSU9OICR7Q01BS0VfSU5TVEFMTF9QUkVGSVh9L3NoYXJlL21h
bikKK2VuZGlmKCkKKworaW5zdGFsbChGSUxFUyBDT1BZSU5HIEFVVEhPUlMgZG9jL2xpYmE1Mi50eHQgREVTVElOQV
RJT04gJHtDTUFLRV9JTlNUQUxMX1BSRUZJWH0vc2hhcmUvZG9jcy9saWJhNTIpCg==
XB64_PATCH


# Filelist
# --------
# include/a52.h
# lib/pkgconfig/liba52.pc
# lib/liba52.a
# lib/liba52.so
# share/man/a52dec.1
# share/man/extract_a52.1
# share/docs/liba52/AUTHORS
# share/docs/liba52/liba52.txt
# share/docs/liba52/COPYING
# bin/extract_a52
# bin/a52dec
