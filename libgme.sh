#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+  .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='libgme'
apt='libgme-dev'
dsc='Blarggs video game music emulation library'
lic='LGPL-2.1'
src='https://bitbucket.org/mpyne/game-music-emu.git'
cfg='cmake'
eta='60'

. xbuilder.sh

start

# Filelist
# --------

# include/gme/blargg_source.h
# include/gme/gme.h
# lib/libgme.so
# lib/pkgconfig/libgme.pc
