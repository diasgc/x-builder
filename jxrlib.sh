#!/bin/bash

#vrs='v2019.10.9'
lib='jxrlib'
pkg='jpegxr'
dsc='JPEG XR Image Codec reference implementation library released by Microsoft'
lic='BSD-2c'
src='https://github.com/4creators/jxrlib.git'
cfg='cmake'
cbk='BUILD_EXECUTABLES'
cstk='BUILD_STATIC_LIBS'

pc_llibs='-ljpegxr -jxrglue'

lst_inc='libjxr/glue/*.h libjxr/image/*.h libjxr/common/*.h libjxr/test/*.h'
lst_lib='libjpegxr libjxrglue'
lst_bin='JxrEncApp JxrDecApp'
lst_lic='LICENSE AUTHORS'
lst_pc='jpegxr.pc xrglue.pc'

. xbuilder.sh

WFLAGS='-Wno-implicit-int
  -Wno-endif-labels
  -Wno-dangling-else
  -Wno-incompatible-pointer-types
  -Wno-shift-negative-value
  -Wno-unused-value'

start

# patch 01: provides cmake build with dual static shared support
<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMudHh0CTIwMjItMDEtMjUgMTk6MDk6NTIuNDk5MDk4NDAwICswMDAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIyLTAxLTI1IDE5OjA4OjQ1Ljg5OTA5ODQwMCArMDAwMApAQCAt
MCwwICsxLDg4IEBACitjbWFrZV9taW5pbXVtX3JlcXVpcmVkKFZFUlNJT04gMi44KQorcHJvamVj
dChqeHJsaWIgQykKKworc2V0KEpYUkxJQl9NQUpPUiAwKQorc2V0KEpYUkxJQl9NSU5PUiAwKQor
CitzZXQoSlhSTElCX0xJQl9WRVJTSU9OICR7SlhSTElCX01BSk9SfS4ke0pYUkxJQl9NSU5PUn0u
MCkKK3NldChKWFJMSUJfU09fVkVSU0lPTiAke0pYUkxJQl9NQUpPUn0pCisKK2luY2x1ZGUoVGVz
dEJpZ0VuZGlhbikKK3Rlc3RfYmlnX2VuZGlhbihJU0JJR0VORElBTikKK2lmKElTQklHRU5ESUFO
KQorICBzZXQoREVGX0VORElBTiAtRF9CSUdfX0VORElBTl8pCitlbmRpZigpCisKK2FkZF9kZWZp
bml0aW9ucygtRF9fQU5TSV9fIC1ERElTQUJMRV9QRVJGX01FQVNVUkVNRU5UICR7REVGX0VORElB
Tn0pCisKK2luY2x1ZGVfZGlyZWN0b3JpZXMoCisgIGNvbW1vbi9pbmNsdWRlCisgIGltYWdlL3N5
cworICBqeHJnbHVlbGliCisgIGp4cnRlc3RsaWIKKykKKworIyBKWFIgTGlicmFyeQorZmlsZShH
TE9CIGpwZWd4cl9TUkMgaW1hZ2Uvc3lzLyouYyBpbWFnZS9kZWNvZGUvKi5jIGltYWdlL2VuY29k
ZS8qLmMpCitmaWxlKEdMT0IganBlZ3hyX0hEUiBpbWFnZS9zeXMvKi5oIGltYWdlL2RlY29kZS8q
LmggaW1hZ2UvZW5jb2RlLyouaCkKKworYWRkX2xpYnJhcnkoanBlZ3hyX29iaiBPQkpFQ1QgJHtq
cGVneHJfU1JDfSAke2pwZWd4cl9IRFJ9KQorCithZGRfbGlicmFyeShqcGVneHIgJDxUQVJHRVRf
T0JKRUNUUzpqcGVneHJfb2JqPikKK3NldF90YXJnZXRfcHJvcGVydGllcyhqcGVneHIgUFJPUEVS
VElFUyBWRVJTSU9OICR7SlhSTElCX0xJQl9WRVJTSU9OfSBTT1ZFUlNJT04gJHtKWFJMSUJfU09f
VkVSU0lPTn0pCisKKyMgSlhSLUdMVUUgTGlicmFyeQorZmlsZShHTE9CIGp4cmdsdWVfU1JDIGp4
cmdsdWVsaWIvKi5jIGp4cnRlc3RsaWIvKi5jKQorZmlsZShHTE9CIGp4cmdsdWVfSERSIGp4cmds
dWVsaWIvKi5oIGp4cnRlc3RsaWIvKi5oKQorCithZGRfbGlicmFyeShqeHJfb2JqIE9CSkVDVCAk
e2p4cmdsdWVfU1JDfSAke2p4cmdsdWVfSERSfSkKK2FkZF9saWJyYXJ5KGp4cmdsdWUgJDxUQVJH
RVRfT0JKRUNUUzpqeHJfb2JqPikKK3NldF90YXJnZXRfcHJvcGVydGllcyhqeHJnbHVlIFBST1BF
UlRJRVMKKyAgVkVSU0lPTiAke0pYUkxJQl9MSUJfVkVSU0lPTn0KKyAgU09WRVJTSU9OICR7SlhS
TElCX1NPX1ZFUlNJT059KQordGFyZ2V0X2xpbmtfbGlicmFyaWVzKGp4cmdsdWUgUFJJVkFURSBq
cGVneHIgbSkKK3NldChqcGVneHJfdGFyZ2V0cyBqcGVneHIganhyZ2x1ZSkKKworaWYoQlVJTERf
U0hBUkVEX0xJQlMgQU5EIEJVSUxEX1NUQVRJQ19MSUJTKQorICBhZGRfbGlicmFyeShqcGVneHJf
c3RhdGljIFNUQVRJQyAkPFRBUkdFVF9PQkpFQ1RTOmpwZWd4cl9vYmo+KQorICBzZXRfdGFyZ2V0
X3Byb3BlcnRpZXMoanBlZ3hyX3N0YXRpYyBQUk9QRVJUSUVTCisgICAgVkVSU0lPTiAke0pYUkxJ
Ql9MSUJfVkVSU0lPTn0KKyAgICBTT1ZFUlNJT04gJHtKWFJMSUJfU09fVkVSU0lPTn0KKyAgICBP
VVRQVVRfTkFNRSBqcGVneHIKKyAgICBSVU5USU1FX09VVFBVVF9OQU1FIGpwZWd4cgorICAgIEFS
Q0hJVkVfT1VUUFVUX05BTUUganBlZ3hyKQorCisgIGFkZF9saWJyYXJ5KGp4cmdsdWVfc3RhdGlj
IFNUQVRJQyAkPFRBUkdFVF9PQkpFQ1RTOmp4cl9vYmo+KQorICBzZXRfdGFyZ2V0X3Byb3BlcnRp
ZXMoanhyZ2x1ZV9zdGF0aWMgUFJPUEVSVElFUworICAgIFZFUlNJT04gJHtKWFJMSUJfTElCX1ZF
UlNJT059CisgICAgU09WRVJTSU9OICR7SlhSTElCX1NPX1ZFUlNJT059CisgICAgT1VUUFVUX05B
TUUganhyZ2x1ZQorICAgIFJVTlRJTUVfT1VUUFVUX05BTUUganhyZ2x1ZQorICAgIEFSQ0hJVkVf
T1VUUFVUX05BTUUganhyZ2x1ZSkKKyAgdGFyZ2V0X2xpbmtfbGlicmFyaWVzKGp4cmdsdWVfc3Rh
dGljIGpwZWd4cl9zdGF0aWMgbSkKKyAgbGlzdChBUFBFTkQganBlZ3hyX3RhcmdldHMganBlZ3hy
X3N0YXRpYyBqeHJnbHVlX3N0YXRpYykKK2VuZGlmKCkKKworaW5zdGFsbChUQVJHRVRTICR7anBl
Z3hyX3RhcmdldHN9CisgIFJVTlRJTUUgREVTVElOQVRJT04gYmluCisgIExJQlJBUlkgREVTVElO
QVRJT04gbGliJHtMSUJfU1VGRklYfQorICBBUkNISVZFIERFU1RJTkFUSU9OIGxpYiR7TElCX1NV
RkZJWH0KKykKKworIyBKeHJFbmNBcHAgRXhlY3V0YWJsZQorYWRkX2V4ZWN1dGFibGUoSnhyRW5j
QXBwIGp4cmVuY29kZXJkZWNvZGVyL0p4ckVuY0FwcC5jKQordGFyZ2V0X2xpbmtfbGlicmFyaWVz
KEp4ckVuY0FwcCBqeHJnbHVlKQoraW5zdGFsbChUQVJHRVRTIEp4ckVuY0FwcCBSVU5USU1FIERF
U1RJTkFUSU9OIGJpbikKKworIyBKeHJEZWNBcHAgRXhlY3V0YWJsZQorYWRkX2V4ZWN1dGFibGUo
SnhyRGVjQXBwIGp4cmVuY29kZXJkZWNvZGVyL0p4ckRlY0FwcC5jKQordGFyZ2V0X2xpbmtfbGli
cmFyaWVzKEp4ckRlY0FwcCBqeHJnbHVlKQoraW5zdGFsbChUQVJHRVRTIEp4ckRlY0FwcCBSVU5U
SU1FIERFU1RJTkFUSU9OIGJpbikKKworIyBIZWFkZXJzCitpbnN0YWxsKEZJTEVTIGp4cmdsdWVs
aWIvSlhSR2x1ZS5oIGp4cmdsdWVsaWIvSlhSTWV0YS5oIGp4cnRlc3RsaWIvSlhSVGVzdC5oIGlt
YWdlL3N5cy93aW5kb3dzbWVkaWFwaG90by5oCisgIERFU1RJTkFUSU9OIGluY2x1ZGUvanhybGli
CispCitpbnN0YWxsKERJUkVDVE9SWSBjb21tb24vaW5jbHVkZS8gREVTVElOQVRJT04gaW5jbHVk
ZS9qeHJsaWIKKyAgRklMRVNfTUFUQ0hJTkcgUEFUVEVSTiAiKi5oIgorKQo=
XB64_PATCH

# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# Filelist
# --------
# include/jxrlib/JXRMeta.h
# include/jxrlib/JXRGlue.h
# include/jxrlib/wmspecstrings_undef.h
# include/jxrlib/JXRTest.h
# include/jxrlib/wmspecstring.h
# include/jxrlib/wmspecstrings_strict.h
# include/jxrlib/windowsmediaphoto.h
# include/jxrlib/guiddef.h
# include/jxrlib/wmspecstrings_adt.h
# include/jxrlib/wmsal.h
# lib/pkgconfig/-jxrglue.pc
# lib/pkgconfig/jpegxr.pc
# lib/libjpegxr.a
# lib/libjpegxr.so
# lib/libjxrglue.a
# lib/libjxrglue.so
# share/doc/jxrlib/LICENSE
# bin/JxrEncApp
# bin/JxrDecApp
