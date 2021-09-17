#!/bin/bash
# HEADER-----------------------------------
lib='lv2'
dsc='An extensible audio plugin interface'
lic='LGPL-2.1'
src='https://gitlab.com/lv2/lv2.git'
sty='git'
cfg='wf'
tls=''
dep=''
eta='19'
pkg='lv2'
lsz=1168
psz=1572
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

# Required function buildLib
buildLib(){

  doLog 'waf-conf' ./waf configure --prefix=${INSTALL_DIR}
  doLog 'waf-make' ./waf
  doLog 'waf-install' ./waf install
}

start