#!/bin/bash

lib='freetype'
pkg='freetype2'
apt='libfreetype-dev'
dsc='A free, high-quality, and portable font engine.'
lic='BSD'
src='https://git.savannah.nongnu.org/r/freetype/freetype2.git'
cfg='ag'
dep='libpng brotli bzip2'
eta='60'

lst_inc='freetype2/*.h freetype2/freetype/*.h'
lst_lib='libfreetype'
lst_bin=''
lst_lic='docs/FTL.TXT docs/GPLv2.TXT docs/LICENSE.TXT'
lst_pc='freetype2.pc'

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc
