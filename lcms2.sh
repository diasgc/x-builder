#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='lcms2'
apt='liblcms2-dev'
dsc='A free, open source, CMM engine. It provides fast transforms between ICC profiles'
lic='BSD-2c'
src='https://github.com/mm2/Little-CMS.git'
cfg='ac'
dep='libjpeg libtiff'
eta='90'

lst_inc='lcms2_plugin.h lcms2.h'
lst_lib='liblcms2.*'
lst_bin='linkicc psicc tificc jpgicc transicc'
lst_lic='COPYING AUTHORS'
lst_pc='lcms2.pc'

. xbuilder.sh

start