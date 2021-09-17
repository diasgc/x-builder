#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libgsm'
dsc='GSM 06.10 lossy speech compression'
lic='LGPL-2.1'
vrs='1.0.19'
src="http://www.quut.com/gsm/gsm-${vrs}.tar.gz"
sty='tgz'
cfg='mk'
tls=''
dep=''
pkg='libgsm'

eta='60'
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
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR
loadToolchain
CFG="CC=${CC} AR=${AR} RANLIB=${RANLIB} INSTALL_ROOT=${INSTALL_DIR}"

# Use function buildSrc to custom clone repo
buildSrc(){
	getTarGZ $src
  mv gsm-* libgsm
}
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  doLog 'make' ${MAKE_EXECUTABLE} $CFG -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install
}
# Use function buildPC to manually build pkg-config .pc file

start