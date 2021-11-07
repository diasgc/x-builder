#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# cannot autoreconf/autogen without gkt-doc from git
# requires cargo/rust

lib='librsvg'
apt='librsvg2-dev'
dsc='A small library to render Scalable Vector Graphics (SVG)'
lic='LGPL-2.1'
src='https://gitlab.gnome.org/GNOME/librsvg.git'
sty='git'
#vrs='2.48.8'
#src="http://ftp.gnome.org/pub/gnome/sources/librsvg/2.48/librsvg-${vrs}.tar.xz"
#sty='txz'
cfg='ag'

eta='110'
cb0="--disable-tools"
cb1="--enable-tools"

. xbuilder.sh

start