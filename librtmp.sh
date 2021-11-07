#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  F   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='librtmp'
dsc='rtmpdump is a toolkit for RTMP streams. All forms of RTMP are supported, including rtmp://, rtmpt://, rtmpe://, rtmpte://, and rtmps://.'
lic='GLP-2.0'
src='git://git.ffmpeg.org/rtmpdump' sty='git'
cfg='make'
dep='zlib openssl'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

export XCFLAGS=$CFLAGS XLDFLAGS=$LDFLAGS INC=$CPPFLAGS
mkf="prefix=${INSTALL_DIR}"
mki='install'
mkc='clean'

source_patch(){
    sed -i 's/^CC=/# &/g;s/^LD=/# &/g;s/^AR=/# &/g' $SRCDIR/Makefile $SRCDIR/librtmp/Makefile
}

start