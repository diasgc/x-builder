#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin


lib='kvazaar'
dsc='An open source C library for efficient image processing and image analysis operations'
lic='LGPL-2.1'
src='https://github.com/ultravideo/kvazaar.git'
cfg='ag'
eta='70'

. xbuilder.sh $@ --ndkLrt

start

# Filelist
# --------

# include/kvazaar.h
# lib/pkgconfig/kvazaar.pc
# lib/libkvazaar.so
# lib/libkvazaar.la
# lib/libkvazaar.a
# share/man/man1/kvazaar.1
# share/doc/kvazaar/README.md
# share/doc/kvazaar/CREDITS
# share/doc/kvazaar/COPYING
# bin/kvazaar
