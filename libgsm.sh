#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libgsm'
apt='libgsm1-dev'
dsc='GSM 06.10 lossy speech compression'
lic='LGPL-2.1'
vrs='1.0.19'
src="http://www.quut.com/gsm/gsm-${vrs}.tar.gz"
sty='tgz'
cfg='mk'
eta='60'
pc_llib="-lgsm"

. xbuilder.sh

CFG="CC=${CC} AR=${AR} RANLIB=${RANLIB}"

# cannot install!!
gsm_install(){
  pushdir $BUILD_DIR
  make $CFG GSM_INSTALL_ROOT=$1 TOAST_INSTALL_ROOT=$1 install
  popdir
}

build_install(){
  gsm_install $INSTALL_DIR
}

build_make_package(){
  gsm_install $1
}

start