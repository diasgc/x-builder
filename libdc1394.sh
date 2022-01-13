#!/bin/bash
# cpu av8 av7 x86 x64
# NDK --------------- clang
# GNU  .   .   .   .  gcc
# WIN --------------- clang/gcc

# CLANG: capture.c contains clang-incompatible VLAiS 

lib='libdc1394'
apt='libdc1394-dev'
dsc='IIDC Camera Control Library '
lic='LGPL-2.1'
src='https://github.com/indigo-astronomy/libdc1394.git'
#src='https://git.code.sf.net/p/libdc1394/code.git'
#automake_cmd='autoreconf -is'
eta='60'

. xbuilder.sh

$host_clang && doErr "Clang does not support compile code with VLAiS. Aborting."

source_config(){
    pushd $SRCDIR
    autoreconf -i -s
    popd
}

start