#!/bin/bash

lib='fontconfig'
dsc='Font customization and configuration library'
lic='Other'
src='https://gitlab.freedesktop.org/fontconfig/fontconfig.git'
cfg='ac'
tls='gperf gettext autopoint'
dep='libiconv freetype expat json-c libpng'
eta='60'

lst_inc='fontconfig/*.h'
lst_lib='libfontconfig.*'
lst_bin='fc-match fc-cat fc-list fc-conflist fc-query fc-scan fc-pattern fc-validate fc-cache'
lst_lic='COPYING AUTHORS'
lst_pc='fontconfig.pc'

. xbuilder.sh

case $build_tool in
    automake) CFG="--disable-docs"; exec_config="autogen.sh";;
    meson) CFG="-Db_pie=true -Db_lto=true -Ddoc=disabled -Dtests=disabled"; MAKE_EXECUTABLE=ninja;; #not recomended
esac

start

# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc