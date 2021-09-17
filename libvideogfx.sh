#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

# FATAL ERROR 'sys/soundcard.h' file not found

lib='libvideogfx'
dsc='Rapid prototyping library for graphics and video processing.'
lic='LGPL-3.0'
src='https://github.com/farindk/libvideogfx.git'
sty='git'
cfg='ag'
eta='120'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start