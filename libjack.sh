#!/bin/bash
# HEADER-----------------------------------
lib='libjack'
dsc='Jack Audio Connection Kit: a low-latency synchronous callback-based media server'
lic='GPL-2.0'
src='https://github.com/jackaudio/jack2.git'
sty='git'
cfg='ac'
tls='python'
dep=''
eta='30'
pkg='libjack'
# -----------------------------------------
# required extraopts
extraOpts(){
  case $1 in
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG=
CSH=
CBN=
dbld=$SRCDIR

# HEADER-----------------------------------
loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} $CFG"; fi

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  doLog 'configure' waf --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  doLog 'install' ${MAKE_EXECUTABLE} install
}
start