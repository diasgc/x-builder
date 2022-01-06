#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++ .   .  clang
# GNU +++ +++ .  +++ gcc
# WIN +++ .   .  +++ clang/gcc

lib='density'
dsc='Small & portable byte-aligned LZ77 compression'
lic='BSD-3c'
#vrs='0.14.2'
src='https://github.com/k0dai/density.git'
cfg='cmake'
eta='30'
pc_llib='-ldensity'
pc_url='https://github.com/k0dai/density'

. xbuilder.sh

CFG="-DBUILD_BENCHMARK=ON"

source_config(){
  cd $SRCDIR
  git submodule update --init --recursive
  cd ..
}

start

<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMudHh0CTIwMjEtMTAtMzAgMTY6Mjg6MTMuODQ1MDQ2MzAwICswMTAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIxLTEwLTMwIDE2OjI2OjIyLjA2NTA0NjMwMCArMDEwMApAQCAt
MCwwICsxLDQ2IEBACitjbWFrZV9taW5pbXVtX3JlcXVpcmVkKFZFUlNJT04gMy4xMCkKKworcHJv
amVjdChkZW5zaXR5IEMpCisKK29wdGlvbihCVUlMRF9TVEFUSUNfTElCUyAiQnVpbGQgc3RhdGlj
IGxpYnMiIE9OKQorb3B0aW9uKEJVSUxEX0JFTkNITUFSSyAiQnVpbGQgYmVuY2htYXJrIiBPRkYp
CisKK2FkZF9jb21waWxlX29wdGlvbnMoIi1Xbm8tZm9ybWF0IikKKworZmlsZShHTE9CX1JFQ1VS
U0UgU1JDIHNyYy8qLmMpCitmaWxlKEdMT0JfUkVDVVJTRSBIRFIgc3JjLyouaCkKKworaWYoQlVJ
TERfU0hBUkVEX0xJQlMpCisgIGFkZF9saWJyYXJ5KGRlbnNpdHkgU0hBUkVEICR7U1JDfSkKK2Vu
ZGlmKCkKKworaWYoQlVJTERfU1RBVElDX0xJQlMpCisgIGFkZF9saWJyYXJ5KGRlbnNpdHlfc3Rh
dGljIFNUQVRJQyAke1NSQ30pCisgIHNldF90YXJnZXRfcHJvcGVydGllcyhkZW5zaXR5X3N0YXRp
YyBQUk9QRVJUSUVTIE9VVFBVVF9OQU1FIGRlbnNpdHkpCitlbmRpZigpCisKK2lmKEJVSUxEX0JF
TkNITUFSSykKKyAgZmlsZShHTE9CX1JFQ1VSU0Ugc3JjX2NwdXRpbWUgYmVuY2htYXJrL2xpYnMv
Y3B1dGltZS9zcmMvKi5jKQorICBhZGRfbGlicmFyeShjcHV0aW1lIFNUQVRJQyAke3NyY19jcHV0
aW1lfSkKKyAgZmlsZShHTE9CX1JFQ1VSU0Ugc3JjX3Nwb29reWhhc2ggYmVuY2htYXJrL2xpYnMv
c3Bvb2t5aGFzaC9zcmMvKi5jKQorICBhZGRfbGlicmFyeShzcG9va3loYXNoIFNUQVRJQyAke3Ny
Y19zcG9va3loYXNofSkKKyAgYWRkX2V4ZWN1dGFibGUoYmVuY2htYXJrIGJlbmNobWFyay9zcmMv
YmVuY2htYXJrLmMpCisgIHRhcmdldF9saW5rX2xpYnJhcmllcyhiZW5jaG1hcmsgZGVuc2l0eSBj
cHV0aW1lIHNwb29reWhhc2gpCitlbmRpZigpCisKK2lmKEJVSUxEX1NIQVJFRF9MSUJTKQorICBp
bnN0YWxsKFRBUkdFVFMgZGVuc2l0eQorICAgIFJVTlRJTUUgREVTVElOQVRJT04gYmluCisgICAg
QVJDSElWRSBERVNUSU5BVElPTiBsaWIke0xJQl9TVUZGSVh9CisgICAgTElCUkFSWSBERVNUSU5B
VElPTiBsaWIke0xJQl9TVUZGSVh9KQorZW5kaWYoKQorCitpZihCVUlMRF9TVEFUSUNfTElCUykK
KyAgaW5zdGFsbChUQVJHRVRTIGRlbnNpdHlfc3RhdGljIEFSQ0hJVkUgREVTVElOQVRJT04gbGli
JHtMSUJfU1VGRklYfSkKK2VuZGlmKCkKKworaW5zdGFsbChGSUxFUyAke0hEUn0gREVTVElOQVRJ
T04gaW5jbHVkZSkKKworaWYoQlVJTERfQkVOQ0hNQVJLKQorICBpbnN0YWxsKFRBUkdFVFMgYmVu
Y2htYXJrIFJVTlRJTUUgREVTVElOQVRJT04gYmluKQorZW5kaWYoKQ==
XB64_PATCH

# Filelist
# --------
# include/lion_encode.h
# include/globals.h
# include/algorithms.h
# include/buffer.h
# include/dictionaries.h
# include/lion_decode.h
# include/cheetah_encode.h
# include/lion.h
# include/lion_form_model.h
# include/chameleon_dictionary.h
# include/chameleon_encode.h
# include/cheetah.h
# include/cheetah_decode.h
# include/cheetah_dictionary.h
# include/lion_dictionary.h
# include/header.h
# include/chameleon_decode.h
# include/chameleon.h
# include/density_api.h
# lib/pkgconfig/density.pc
# lib/libdensity.a
# lib/libdensity.so
# bin/benchmark
