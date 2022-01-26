#!/bin/bash

lib='cairo'
apt='libcairo2-dev'
dsc='Development files for the Cairo 2D graphics library'
lic='LGPL-2.1'
#src='https://github.com/freedesktop/cairo.git'
src='https://cairographics.org/releases/cairo-5c-1.20.tar.gz'
cfg='ar'
dep='fontconfig'
eta='275'
#CFG="--disable-gtk-doc-html --disable-gl --enable-gobject --enable-pdf --enable-svg --enable-ps"

. xbuilder.sh

start

# cpu av8 av7 x86 x64
# NDK  F   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc