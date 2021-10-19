#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='ffnvcodec'
dsc='FFmpeg nvidia headers'
lic='GLP-2.0'
src='https://git.videolan.org/git/ffmpeg/nv-codec-headers.git'
sty='git'
cfg='make'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh
mki="PREFIX=${INSTALL_DIR} install"
start

# Filelist
# --------
# include/ffnvcodec/dynlink_cuda.h
# include/ffnvcodec/nvEncodeAPI.h
# include/ffnvcodec/dynlink_loader.h
# include/ffnvcodec/dynlink_cuviddec.h
# include/ffnvcodec/dynlink_nvcuvid.h
# ffnvcodec.pc
