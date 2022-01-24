#!/bin/bash
# fail to build plugins
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  F   .   .   .   .   .   .   .   .   .   .  shared
#  F   .   .   .   .   .   .   .   .   .   .  bin

lib='ladspa'
apt='ladspa-sdk'
dsc='Linux Audio Developers Simple Plugin API'
lic='LGPL'
vrs='1.16'
src="http://www.ladspa.org/download/ladspa_sdk_${vrs}.tgz"
cfg='mk'
dep='sndfile'
eta='60'
pc_llib='-lladspa'

. xbuilder.sh

SRCDIR=$SRCDIR/src
dbld=$SRCDIR

build_patch_config(){
	CFG=("CC=$CC" "CPP=$CXX" \
	"INSTALL_PLUGINS_DIR=${dir_install_lib}" \
	"INSTALL_INCLUDE_DIR=${dir_install_inc}" \
	"INSTALL_BINARY_DIR=${dir_install_bin}")

	sed -i "s|-I.$|-I. -I${dir_install_inc}|g" Makefile
	sed -i "s|-ldl -lm -lsndfile|-ldl -lm -L${dir_install_lib} -lsndfile|g" Makefile
	sed -i "s|-Werror|-Wno-error|g" Makefile
}

start