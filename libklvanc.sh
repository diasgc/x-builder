#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libklvanc'
apt=''
dsc='VANC Processing Framework'
lic='LGPL-2.1'
vrs='0.0.0' # no version
src='https://github.com/stoth68000/libklvanc.git'
sty='git'
cfg='ac'
eta='60'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --disable-tests --enable-rpath --disable-dsd --enable-legacy --with-pic=1"
pkgconfig_llib="-lklvanc"

source_patch(){
    pushdir $SRCDIR
    ./autogen.sh --build
    popdir
}

start

# Filelist
# --------

# include/libklvanc/cache.h
# include/libklvanc/vanc-afd.h
# include/libklvanc/vanc.h
# include/libklvanc/vanc-eia_708b.h
# include/libklvanc/vanc-sdp.h
# include/libklvanc/vanc-eia_608.h
# include/libklvanc/vanc-kl_u64le_counter.h
# include/libklvanc/vanc-lines.h
# include/libklvanc/klrestricted_code_path.h
# include/libklvanc/vanc-scte_104.h
# include/libklvanc/vanc-smpte_12_2.h
# include/libklvanc/vanc-checksum.h
# include/libklvanc/vanc-packets.h
# include/libklvanc/pixels.h
# include/libklvanc/smpte2038.h
# include/libklvanc/did.h
# lib/libklvanc.la
# lib/libklvanc.so
# lib/libklvanc.a
# bin/klvanc_eia708
# bin/klvanc_genscte104
# bin/klvanc_scte104
# bin/klvanc_util
# bin/klvanc_afd
# bin/klvanc_smpte12_2
# bin/klvanc_smpte2038
# bin/klvanc_parse
