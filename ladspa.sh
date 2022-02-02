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
vrs='1.17'
src="http://www.ladspa.org/download/ladspa_sdk_${vrs}.tgz"
cfg='cmake'
dep='sndfile'
eta='60'
pc_llib='-lladspa'
config_dir='src'
cmake_static='BUILD_STATIC_LIBS'
build_strip=false

. xbuilder.sh

start

# Filelist
# --------
# libs/ladspa_plugins/libamp.a
# libs/ladspa_plugins/libdelay.a
# libs/ladspa_plugins/libamp.so
# libs/ladspa_plugins/libsine.a
# libs/ladspa_plugins/libsine.so
# libs/ladspa_plugins/libfilter.so
# libs/ladspa_plugins/libnoise.so
# libs/ladspa_plugins/libdelay.so
# libs/ladspa_plugins/libnoise.a
# libs/ladspa_plugins/libfilter.a
# lib/pkgconfig/ladspa.pc
