#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libjack'
dsc='Jack Audio Connection Kit: a low-latency synchronous callback-based media server'
lic='GPL-2.0'
src='https://github.com/jackaudio/jack2.git'
sty='git'
cfg='waf'
tls='python'
dep=''
pkg='libjack'

eta='30'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG=
dbld=$SRCDIR
loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} $CFG"; fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  doLog 'configure' waf --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install
}
# Use function buildPC to manually build pkg-config .pc file


start