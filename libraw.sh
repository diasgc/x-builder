#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libraw'
dsc='Raw image decoder library (non-thread-safe)'
lic='LGPL-2.1 CDDL'
src='https://github.com/LibRaw/LibRaw.git'
sty='git'
cfg='ar'
dep='libjpeg lcms2 jasper'
eta='60'
cb0="--disable-examples"
cb1="--enable-examples"

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start