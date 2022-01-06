#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libjack'
apt="${lib}-dev"
dsc='Jack Audio Connection Kit: a low-latency synchronous callback-based media server'
lic='GPL-2.0'
src='https://github.com/jackaudio/jack2.git'
sty='git'
cfg='waf'
tls='python'
eta='30'

. xbuilder.sh

CFG="--prefix=${INSTALL_DIR} --doxygen=no"

build_clean(){
  doLog 'clean' $SRCDIR/waf distclean
}
build_config(){
  doLog 'config' $SRCDIR/waf configure $CFG
}
build_make(){
  $SRCDIR/waf build $CFG
}
build_install(){
  $SRCDIR/waf install --prefix=${INSTALL_DIR}
}
build_make_package(){
  $SRCDIR/waf install --prefix=${1}
}

start