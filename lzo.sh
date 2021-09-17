#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   +   .   .   .   .   .  shared
#  +   .   .   .   .   +   .   .   .   .   .  bin

lib='lzo'
pkg='lzo2'
dsc='LZO is a portable lossless data compression library written in ANSI C'
lic='GPL2+'
vrs='2.10'
src="http://www.oberhumer.com/opensource/lzo/download/lzo-${vrs}.tar.gz"
sty='tgz'
cfg='cm'
eta='10'
cstk="ENABLE_STATIC"
cshk="ENABLE_SHARED"

. xbuilder.sh

start


# Filelist
# --------
# include/lzo/lzoconf.h
# include/lzo/lzo1f.h
# include/lzo/lzodefs.h
# include/lzo/lzo1z.h
# include/lzo/lzo1c.h
# include/lzo/lzoutil.h
# include/lzo/lzo_asm.h
# include/lzo/lzo1x.h
# include/lzo/lzo1a.h
# include/lzo/lzo1b.h
# include/lzo/lzo1.h
# include/lzo/lzo1y.h
# include/lzo/lzo2a.h
# libexec/lzo/examples/testmini
# libexec/lzo/examples/lzopack
# libexec/lzo/examples/lzotest
# libexec/lzo/examples/simple
# lib/pkgconfig/lzo2.pc
# lib/liblzo2.so
# lib/liblzo2.a
# share/doc/lzo/NEWS
# share/doc/lzo/LZO.TXT
# share/doc/lzo/LZO.FAQ
# share/doc/lzo/AUTHORS
# share/doc/lzo/THANKS
# share/doc/lzo/LZOAPI.TXT
# share/doc/lzo/COPYING
