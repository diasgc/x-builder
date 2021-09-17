#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   +   F   .   .   .   .   .  static
#  .   .   .   .   +   .   .   .   .   .   .  shared
#  .   .   .   .   +   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='dav1d'
dsc='AV1 cross-platform decoder, open-source, and focused on speed and correctness.'
lic='GPL-2.0'
src='https://code.videolan.org/videolan/dav1d.git'
sty='git'
cfg=''
tls='meson'
dep=''
pkg='dav1d'

eta='40'
lsz=
psz=
ets=(20 0 0 40 46 69 18 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0=
# "--default-library=static"
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG=
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="--cross-file=$(pwd)/cmake/${arch}.meson"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

buildLib(){
  #${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  doLog 'meson' meson $CFG --prefix=${INSTALL_DIR} $CSH $CBN
  doLog 'ninja' ninja -j${HOST_NPROC}
  #doLog 'install' ${MAKE_EXECUTABLE} install
}
# Use function buildPC to manually build pkg-config .pc file

start