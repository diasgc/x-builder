#!/bin/bash

lib='cairo'
apt='libcairo2-dev'
dsc='Development files for the Cairo 2D graphics library'
lic='LGPL-2.1'
src='https://github.com/freedesktop/cairo.git'
#src='https://cairographics.org/releases/cairo-5c-1.20.tar.gz'
cfg='meson'
dep='fontconfig freetype'
eta='275'
#CFG="--disable-gtk-doc-html --disable-gl --enable-gobject --enable-pdf --enable-svg --enable-ps"
cfg_meson='-Dxcb=disabled -Dxlib=disabled -Dxlib-xcb=disabled -Dtests=disabled -Dquartz=disabled -Dsymbol-lookup=disabled -Dspectre=disabled'

dev_bra='master'
dev_vrs=''
stb_bra='1.16'
stb_vrs=''

lst_inc=''
lst_lib=''
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc=''

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK  F   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc