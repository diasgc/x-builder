#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='liblzma'
apt="${lib}-dev"
dsc='General purpose data compression library'
lic='GPL-3 LGPL-2.1'
vrs='v5.2.5' #stable
src='https://git.tukaani.org/xz.git'
sty='git'
cfg='ac'
eta='110'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-doc"

source_patch(){
  doAutogen $SRCDIR --noerr
}

start

# Filelist
# --------
# include/lzma/stream_flags.h
# include/lzma/index.h
# include/lzma/check.h
# include/lzma/container.h
# include/lzma/vli.h
# include/lzma/hardware.h
# include/lzma/delta.h
# include/lzma/base.h
# include/lzma/bcj.h
# include/lzma/filter.h
# include/lzma/version.h
# include/lzma/lzma12.h
# include/lzma/block.h
# include/lzma/index_hash.h
# include/lzma.h
# lib/pkgconfig/liblzma.pc
# lib/liblzma.a
# lib/liblzma.la
# lib/liblzma.so
# share/man/man1/xz.1
# share/man/man1/xzless.1
# share/man/man1/xzgrep.1
# share/man/man1/lzmainfo.1
# share/man/man1/xzdec.1
# share/man/man1/xzmore.1
# share/man/man1/xzdiff.1
# bin/xzmore
# bin/xzdec
# bin/xzgrep
# bin/xz
# bin/lzmainfo
# bin/xzless
# bin/lzmadec
# bin/xzdiff
