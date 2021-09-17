#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +-  .   .   .   .   .   .   .   .   .   .  static
#  +-  .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

# ISSUES
#  - cannot build both static & shared

lib='lerc'
pkg='Lerc'
dsc='Limited Error Raster Compression'
lic='BSD/GPL-2.0'
src='https://github.com/Esri/lerc.git'
sty='git'
cfg='cm'
eta='134'

. xbuilder.sh

start

# Filelist
# --------

# include/Lerc_c_api.h
# include/Lerc_types.h
# lib/pkgconfig/Lerc.pc
# lib/libLerc.so
