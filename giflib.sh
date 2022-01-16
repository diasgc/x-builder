#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ clang
# GNU +++ +++  .   .  gcc
# WIN +++ +++  .   .  clang/gcc

lib='giflib'
apt='libgif-dev'
dsc='Library for manipulating GIF files'
lic='other'
src='https://git.code.sf.net/p/giflib/code.git'
cfg='cmake'
pc_llib='-lgif'
eta='18'
lst_inc='gif_lib.h'
lst_lib='libgiflib'
lst_bin='giftext gifsponge giffilter giffix gifecho \
         gifbg gifhisto gifwedge giftool gifclrmp \
         gif2rgb gifcolor gifbuild gifinto'
dll='libgiflib-7'
cbk="BUILD_UTILITIES"

. xbuilder.sh

start

<<'XB_PATCH'
Y21ha2VfbWluaW11bV9yZXF1aXJlZChWRVJTSU9OIDIuOC4xMikKCnByb2plY3QoZ2lmbGliIEMp
CgpvcHRpb24oQlVJTERfU1RBVElDX0xJQlMgIkJ1aWxkIHN0YXRpYyBsaWJzIiBPTikKb3B0aW9u
KEJVSUxEX1VUSUxJVElFUyAiQnVpbGQgdXRpbGl0aWVzIiBPRkYpCm9wdGlvbihJTlNUQUxMX01B
TiAiSW5zdGFsbCBtYW4iIE9GRikKb3B0aW9uKElOU1RBTExfRE9DUyAiSW5zdGFsbCBkb2NzIiBP
RkYpCgpleGVjdXRlX3Byb2Nlc3MoQ09NTUFORCAuL2dldHZlcnNpb24KICAgIFdPUktJTkdfRElS
RUNUT1JZICR7Q01BS0VfU09VUkNFX0RJUn0KICAgIE9VVFBVVF9WQVJJQUJMRSBWRVJTSU9OCiAg
ICBPVVRQVVRfU1RSSVBfVFJBSUxJTkdfV0hJVEVTUEFDRQopCgpzZXQoTElCTUFKT1IgNykKc2V0
KExJQk1JTk9SIDEpCnNldChMSUJQT0lOVCAwKQpzZXQoTElCVkVSICIke0xJQk1BSk9SfS4ke0xJ
Qk1JTk9SfS4ke0xJQlBPSU5UfSIpCgpzZXQoZ2lmbGliX1NSQyBkZ2lmX2xpYi5jIGVnaWZfbGli
LmMgZ2V0YXJnLmMKICAgIGdpZmFsbG9jLmMgZ2lmX2Vyci5jIGdpZl9mb250LmMgZ2lmX2hhc2gu
YwogICAgb3BlbmJzZC1yZWFsbG9jYXJyYXkuYyBxcHJpbnRmLmMgcXVhbnRpemUuYwopCgpzZXQo
Z2lmbGliX0lOU1RBTExBQkxFIGdpZjJyZ2IgZ2lmYnVpbGQgZ2lmZWNobwogICAgZ2lmZmlsdGVy
IGdpZmZpeCBnaWZpbnRvIGdpZnRleHQgZ2lmdG9vbAogICAgZ2lmc3BvbmdlIGdpZmNscm1wCikK
CnNldChnaWZsaWJfVVRJTFMgJHtnaWZsaWJfSU5TVEFMTEFCTEV9CiAgICBnaWZiZyBnaWZjb2xv
ciBnaWZoaXN0byBnaWZ3ZWRnZQopCgpzZXQoZ2lmbGliX0RPQ1MgUkVBRE1FIE5FV1MgVE9ETyBD
T1BZSU5HCiAgICBnZXR2ZXJzaW9uIENoYW5nZUxvZyBoaXN0b3J5LmFkb2MKICAgIGNvbnRyb2wg
ZG9jLyoueG1sIGRvYy8qLnR4dAogICAgZG9jL2luZGV4Lmh0bWwuaW4gZG9jLzAwUkVBRE1FCikK
CmlmKElOU1RBTExfTUFOKQogIGZpbGUoR0xPQiBnaWZsaWJfTUFOIGRvYy8qLjEpCmVuZGlmKCkK
CmlmKEJVSUxEX1NIQVJFRF9MSUJTKQogIGFkZF9saWJyYXJ5KGdpZmxpYiBTSEFSRUQgJHtnaWZs
aWJfU1JDfSkKICB0YXJnZXRfbGlua19saWJyYXJpZXMoZ2lmbGliIG0pCiAgc2V0X3RhcmdldF9w
cm9wZXJ0aWVzKGdpZmxpYiBQUk9QRVJUSUVTIFZFUlNJT04gJHtMSUJWRVJ9IFNPVkVSU0lPTiAk
e0xJQk1BSk9SfSkKICBpZihXSU4zMikKICAgIHNldF90YXJnZXRfcHJvcGVydGllcyhnaWZsaWIg
UFJPUEVSVElFUyBTVUZGSVggIi0ke0xJQk1BSk9SfSR7Q01BS0VfU0hBUkVEX0xJQlJBUllfU1VG
RklYfSIpCiAgZW5kaWYoV0lOMzIpCmVuZGlmKCkKCmlmKEJVSUxEX1NUQVRJQ19MSUJTKQogIGFk
ZF9saWJyYXJ5KGdpZmxpYl9zdGF0aWMgU1RBVElDICR7Z2lmbGliX1NSQ30pCiAgc2V0X3Rhcmdl
dF9wcm9wZXJ0aWVzKGdpZmxpYl9zdGF0aWMgUFJPUEVSVElFUyBPVVRQVVRfTkFNRSBnaWZsaWIp
CmVuZGlmKCkKCmlmKEJVSUxEX1VUSUxJVElFUykKICBmb3JlYWNoKFVUSUxJVFkgJHtnaWZsaWJf
VVRJTFN9KQogICAgYWRkX2V4ZWN1dGFibGUoJHtVVElMSVRZfSAke1VUSUxJVFl9LmMpCiAgICB0
YXJnZXRfbGlua19saWJyYXJpZXMoJHtVVElMSVRZfSBnaWZsaWIpCiAgZW5kZm9yZWFjaCgpCmVu
ZGlmKCkKCmlmKEJVSUxEX1NIQVJFRF9MSUJTKQogIGluc3RhbGwoVEFSR0VUUyBnaWZsaWIKICAg
IFJVTlRJTUUgREVTVElOQVRJT04gYmluCiAgICBBUkNISVZFIERFU1RJTkFUSU9OIGxpYiR7TElC
X1NVRkZJWH0KICAgIExJQlJBUlkgREVTVElOQVRJT04gbGliJHtMSUJfU1VGRklYfSkKZW5kaWYo
KQoKaWYoQlVJTERfU1RBVElDX0xJQlMpCiAgaW5zdGFsbChUQVJHRVRTIGdpZmxpYl9zdGF0aWMg
QVJDSElWRSBERVNUSU5BVElPTiBsaWIke0xJQl9TVUZGSVh9KQplbmRpZigpCgppZihCVUlMRF9V
VElMSVRJRVMpCiAgZm9yZWFjaChVVElMSVRZICR7Z2lmbGliX1VUSUxTfSkKICAgIGluc3RhbGwo
VEFSR0VUUyAke1VUSUxJVFl9IERFU1RJTkFUSU9OIGJpbikKICBlbmRmb3JlYWNoKCkKZW5kaWYo
KQoKaW5zdGFsbChGSUxFUyBnaWZfbGliLmggREVTVElOQVRJT04gaW5jbHVkZSkKCmlmKElOU1RB
TExfTUFOKQogIGluc3RhbGwoRklMRVMgJHtnaWZsaWJfTUFOfSBERVNUSU5BVElPTiAke0NNQUtF
X0lOU1RBTExfUFJFRklYfS9tYW4vbWFuMSkKZW5kaWYoKQoKaW5zdGFsbChESVJFQ1RPUlkgJHtD
TUFLRV9DVVJSRU5UX1NPVVJDRV9ESVJ9L2RvYwogICAgREVTVElOQVRJT04gJHtDTUFLRV9JTlNU
QUxMX1BSRUZJWH0vc2hhcmUvZ2lmCiAgICBGSUxFU19NQVRDSElORyBQQVRURVJOICIqbWwiKQ==
XB_PATCH

# Filelist
# --------
# include/gif_lib.h
# lib/libgiflib.a
# lib/pkgconfig/giflib.pc
# lib/libgiflib.so
# bin/giftext
# bin/gifsponge
# bin/giffilter
# bin/giffix
# bin/gifecho
# bin/gifbg
# bin/gifhisto
# bin/gifwedge
# bin/giftool
# bin/gifclrmp
# bin/gif2rgb
# bin/gifcolor
# bin/gifbuild
# bin/gifinto
