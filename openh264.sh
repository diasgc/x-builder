#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='openh264'
dsc='Open Source H.264 Codec'
lic='BSD-2c'
src='https://github.com/cisco/openh264.git'
sty='git'
cfg='meson'
tls='meson'
dep=''
pkg='openh264'

eta='42'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG=
dbld=$SRCDIR
loadToolchain

# TODO MESON
# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start