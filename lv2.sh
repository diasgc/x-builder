#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='lv2'
dsc='An extensible audio plugin interface'
lic='LGPL-2.1'
src='https://gitlab.com/lv2/lv2.git'
sty='git'
cfg='wf'
tls=''
dep=''
pkg='lv2'

eta='19'
lsz=1168
psz=1572
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb1
# -----------------------------------------

# enable main toolchain util
. tcutils.sh

# requided defs
CFG=
CSH=
CBN=
dbld=$SRCDIR
# HEADER-----------------------------------

loadToolchain

buildSrc(){
  gitClone $src $lib
  pushd $SRCDIR >/dev/null
  doLog 'prepare' git submodule update --init --recursive
  popd >/dev/null
}

buildLib(){
  doLog 'waf-conf' ./waf configure --prefix=${INSTALL_DIR}
  doLog 'waf-make' ./waf
  doLog 'waf-install' ./waf install
}

start