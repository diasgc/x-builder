#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++ +++ +++  .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .  +++ clang/gcc

lib='wavpack'
dsc='WavPack encode/decode library, command-line programs, and several plugins'
lic='BSD 3-clause'
src='https://github.com/dbry/WavPack.git'
cfg='ar'
dep='libiconv'
eta='30'
cbk="able-apps"

lst_inc='wavpack/wavpack.h'
lst_lib='libwavpack'
lst_bin='wavpack wvgain wvtag wvunpack'

. xbuilder.sh

# cli has glob header that requires api28 for ndk
$build_bin && [ "$host_os" == "android" ] && [ $API -lt 28 ] && set_ndk_api 28

CFG="--enable-maintainer-mode"

$host_arm && CFG+=" --disable-asm"

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
# bin/wavpack
# bin/wvgain
# bin/wvtag
# bin/wvunpack
