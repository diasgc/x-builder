#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libpulse'
dsc='PulseAudio Client Interface'
lic='LGPL-2.1'
src='https://gitlab.freedesktop.org/pulseaudio/pulseaudio.git'
sty='git'
#src='https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-15.0.tar.gz'
#sty='tgz'
cfg='meson'
tls='libtool'
dep='sndfile'
pkg='pulseaudio'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0=
cs1=
cb0=
cb1=
CSH=
CBN=

. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start