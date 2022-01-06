#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libyuv'
dsc='Libyuv is an open source project that includes YUV scaling and conversion functionality'
lic='BSD-3c'
src='https://chromium.googlesource.com/libyuv/libyuv' sty='git'
cfg='cmake'
dep='libjpeg'
eta='0'
pc_llib='-lyuv'
pc_libsprivate='-lpthread -ljpeg'

#cshk=''
#cstk=''
#cbk=''

lst_inc='libyuv.h 
    libyuv/rotate_argb.h libyuv/macros_msa.h libyuv/scale.h libyuv/scale_argb.h 
    libyuv/convert_argb.h libyuv/compare_row.h libyuv/row.h libyuv/planar_functions.h 
    libyuv/scale_uv.h libyuv/scale_row.h libyuv/convert_from.h libyuv/version.h 
    libyuv/convert.h libyuv/cpu_id.h libyuv/convert_from_argb.h libyuv/mjpeg_decoder.h 
    libyuv/compare.h libyuv/rotate_row.h libyuv/rotate.h libyuv/basic_types.h 
    libyuv/video_common.h'
lst_lib='libyuv'
lst_bin='yuvconvert'

. xbuilder.sh

LDFLAGS+=" -ljpeg"

build_patch_config(){
    vrs=$(cat $LOGFILE | grep 'Building ver.: .*' | sed 's|Building ver.: ||')
}

start

<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMudHh0CTIwMjEtMTAtMjggMTE6MjE6MzUuNzY3MDAwMDAwICswMTAwCisr
KyBDTWFrZUxpc3RzLnR4dAkyMDIxLTEwLTI4IDE0OjM4OjUwLjM1OTU0NjIwMCArMDEwMApAQCAt
NzUsNyArNzUsNyBAQAogCiAKICMgaW5zdGFsbCB0aGUgY29udmVyc2lvbiB0b29sLCAuc28sIC5h
LCBhbmQgYWxsIHRoZSBoZWFkZXIgZmlsZXMKLUlOU1RBTEwgKCBQUk9HUkFNUyAke0NNQUtFX0JJ
TkFSWV9ESVJ9L3l1dmNvbnZlcnQJCQlERVNUSU5BVElPTiBiaW4gKQorSU5TVEFMTCAoIFBST0dS
QU1TICR7Q01BS0VfQklOQVJZX0RJUn0veXV2Y29udmVydCR7Q01BS0VfRVhFQ1VUQUJMRV9TVUZG
SVh9CQkJREVTVElOQVRJT04gYmluICkKIElOU1RBTEwgKCBUQVJHRVRTICR7bHlfbGliX3N0YXRp
Y30JCQkJCQlERVNUSU5BVElPTiBsaWIgKQogSU5TVEFMTCAoIFRBUkdFVFMgJHtseV9saWJfc2hh
cmVkfSBMSUJSQVJZCQkJCURFU1RJTkFUSU9OIGxpYiBSVU5USU1FIERFU1RJTkFUSU9OIGJpbiAp
CiBJTlNUQUxMICggRElSRUNUT1JZICR7UFJPSkVDVF9TT1VSQ0VfRElSfS9pbmNsdWRlLwkJREVT
VElOQVRJT04gaW5jbHVkZSApCg==
XB64_PATCH

# Filelist
# --------
# include/libyuv.h
# include/libyuv/rotate_argb.h
# include/libyuv/macros_msa.h
# include/libyuv/scale.h
# include/libyuv/scale_argb.h
# include/libyuv/convert_argb.h
# include/libyuv/compare_row.h
# include/libyuv/row.h
# include/libyuv/planar_functions.h
# include/libyuv/scale_uv.h
# include/libyuv/scale_row.h
# include/libyuv/convert_from.h
# include/libyuv/version.h
# include/libyuv/convert.h
# include/libyuv/cpu_id.h
# include/libyuv/convert_from_argb.h
# include/libyuv/mjpeg_decoder.h
# include/libyuv/compare.h
# include/libyuv/rotate_row.h
# include/libyuv/rotate.h
# include/libyuv/basic_types.h
# include/libyuv/video_common.h
# lib/pkgconfig/libyuv.pc
# lib/libyuv.so
# lib/libyuv.a
# bin/yuvconvert
