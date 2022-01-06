#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   +   .   .  static
#  .   .   .   .   .   .   .   .   +   .   .  shared
#  .   .   .   .   .   .   .   .   +   .   .  bin

lib='lcms2'
apt='liblcms2-dev'
dsc='A free, open source, CMM engine. It provides fast transforms between ICC profiles'
lic='BSD-2c'
src='https://github.com/mm2/Little-CMS.git'
cfg='ac'
dep='libjpeg libtiff'
eta='90'

. xbuilder.sh

start

# Filelist
# --------

# include/lcms2_plugin.h
# include/lcms2.h
# lib/pkgconfig/lcms2.pc
# lib/liblcms2.la
# lib/liblcms2.a
# lib/liblcms2.so
# share/man/man1/jpgicc.1
# share/man/man1/transicc.1
# share/man/man1/psicc.1
# share/man/man1/linkicc.1
# share/man/man1/tificc.1
# bin/linkicc
# bin/psicc
# bin/tificc
# bin/jpgicc
# bin/transicc
