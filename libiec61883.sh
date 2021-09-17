#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libiec61883'
apt="${lib}-dev"
dsc='An isochronous streaming media library for IEEE 1394'
lic='LGPL-2.1'
src='https://github.com/Distrotech/libiec61883.git'
sty='git'
cfg='ar'
dep='libraw1394'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"
[[ $arch = *mingw32 ]] && dep=''

start

# Filelist
# --------

# include/libiec61883/iec61883.h
# share/man/man1/plugctl.1
# share/man/man1/plugreport.1
# lib/libiec61883.so
# lib/libiec61883.a
# lib/pkgconfig/libiec61883.pc
# lib/libiec61883.la
# bin/plugreport
# bin/plugctl
