#!/bin/bash
# HEADER-----------------------------------
lib='libgsm'
dsc='GSM 06.10 lossy speech compression'
lic='LGPL-2.1'
src='http://www.quut.com/gsm/gsm-1.0.19.tar.gz'
vrs='1.0.19'
sty='tgz'
cfg='mk'
tls=''
dep=''
eta='60'
pkg='libgsm'
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

# Required function buildSrc
buildSrc(){
	getTarGZ $src
  mv gsm-* libgsm
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1

  log make
  logme ${MAKE_EXECUTABLE} CC=${CC} AR=${AR} RANLIB=${RANLIB} INSTALL_ROOT=${INSTALL_DIR} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start