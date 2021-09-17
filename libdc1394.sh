#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

# ISSUES:
# android/clang (https://clang.debian.net/status.php?version=3.6.0&key=VARIABLE_LENGTH_ARRAY)
#   control.c:286:19 (juju)
#   capture.c:324:9
#    > error: fields must have a constant size: 'variable length array in structure'
#            __u32 buffer[cam->max_response_quads];

lib='libdc1394'
apt='libdc1394-dev'
dsc='IIDC Camera Control Library '
lic='LGPL-2.1'
src='https://github.com/indigo-astronomy/libdc1394.git'
sty='git'
cfg='ac'
eta='60'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

source_config(){
    pushd $SRCDIR
    autoreconf -i -s
    popd
}

start