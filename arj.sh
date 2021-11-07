#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  F   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='arj'
dsc='Open Source ARJ archiver'
lic='GLP-2.0'
src='https://git.code.sf.net/p/arj/git'
sty='git'
cfg='ar'
eta='60'
ac_nohost=true
dir_config='gnu'
#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

source_config(){
    autoheader 2>/dev/null
    autoconf 2>/dev/null
}

BUILD_DIR="$SRCDIR"
CFG="--host=$(echo ${arch} | sed 's/aarch64/arm/;s/android/gnu/')"
mkf="-f GNUmakefile"
start