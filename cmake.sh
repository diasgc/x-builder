#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   +   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='cmake'
dsc='cross-platform, open-source make system'
lic='BSD 3-clause'
src='https://github.com/Kitware/CMake.git'
sty='git'
cfg=''
tls=''
dep=''

eta='52'

cs0=' '
cs1=' '
# -----------------------------------------

arch="x86_64-linux-gnu"

. xbuilder.sh $arch

MAKE_EXECUTABLE=gmake

source_patch(){
  pushdir $SRCDIR
  doLog 'bootstrap' ./bootstrap
}

start