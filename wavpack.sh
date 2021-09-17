#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  F   .   .   .   .   .   .   .   .   .   .  bin

lib='wavpack'
dsc='WavPack encode/decode library, command-line programs, and several plugins'
lic='BSD 3-clause'
src='https://github.com/dbry/WavPack.git'
sty='git'
cfg='ar'
dep='libiconv'
eta='172'

#cb0="--disable-apps"
#cb1="--enable-apps"

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --enable-apps --enable-maintainer-mode" #--enable-rpath --disable-dsd --enable-legacy 
case $arch in aarch64*|arm*) CFG="$CFG --disable-asm";;esac

source_config(){
    test -f "$SRCDIR/config.rpath" || cp /usr/share/gettext/config.rpath $SRCDIR 2>/dev/null || touch $SRCDIR/config.rpath || exit 1
    doAutoreconf $SRCDIR
}
start

# Filelist
# --------
# include/wavpack/wavpack.h
# lib/pkgconfig/wavpack.pc
# lib/libwavpack.a
# lib/libwavpack.la
# lib/libwavpack.so
# share/man/man1/wvtag.1
# share/man/man1/wvgain.1
# share/man/man1/wvunpack.1
# share/man/man1/wavpack.1
