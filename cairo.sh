#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='cairo'
apt='libcairo2-dev'
dsc='Development files for the Cairo 2D graphics library'
lic='LGPL-2.1'
src='https://github.com/freedesktop/cairo.git'
cfg='ag'
dep='fontconfig'
tls='build-dep cairo'
eta='275'
CFG="--enable-xlib=no --enable-xlib-xrender=no --enable-xcb=no --enable-png=no"

. xbuilder.sh

start